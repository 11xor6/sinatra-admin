#!/usr/bin/env ruby

require 'timeout'
require 'yaml'
#require 'rubygems'

@base_dir = "."
@command = ARGV[0]

PID_FILE = File.join(@base_dir, 'launcher.pid')
LOG_FILE = File.join(@base_dir, 'launcher.log')

# Check whether a given process PID is alive or not.
def is_alive pid
  begin
    return Process.kill(0, pid) == 1
  rescue Errno::ESRCH
    return false
  end
end

# Load Process PID
def load_pid pid_file=PID_FILE
  pid = nil

  begin
    File.open pid_file do |f|
      pid = f.read.to_i
    end

    pid = nil unless is_alive pid
  rescue Errno::ENOENT
    pid = nil
  end

  return pid
end


# Save Process PID
def save_pid pid
  File.open PID_FILE, 'w' do |f|
    f.puts pid
  end
end

#
# Wait for a child process to die.
#
def wait_stopped pid
  loop do
    break unless is_alive pid
    sleep 0.1
  end
end

# Load launcher type contents
def load_launcher_data launcher_data_file="bin/LAUNCHER_TYPE"
  launcher_data = nil

  begin
    File.open launcher_data_file do |f|
      launcher_data = YAML.load(f.read)
    end
  rescue Errno::ENOENT
  end

  return {'launcher_main' => 'org.jruby.Main'}
end

#
# Executes the actual child process.
# Reopens stdout and stderr to the general
# log file.
def execute main_class
  STDOUT.reopen LOG_FILE, 'a'
  STDERR.reopen STDOUT

  classpath=Dir.entries(File.join(@base_dir, 'lib')).select {|dir| dir =~ /\.jar$/ }.collect { |dir| "lib/#{dir}" }.join(":")
  prgm_args = "-e \"require 'rubygems'\" -e \"require 'jetty-rackup'\""
  environment = "GEM_HOME=.gems GEM_PATH=.gems"
  STDERR.puts "=" * 72
  STDERR.puts "=== program args: #{prgm_args}"
  STDERR.puts "=== classpath:    #{classpath}"
  STDERR.puts "=== environment:  #{environment}"
  STDERR.puts "=" * 72

  puts "starting service..."
  Dir.chdir @base_dir
  command="env #{environment} java -classpath #{classpath} #{main_class} #{prgm_args}"
  exec command
end

# Start command
def start
  pid = load_pid

  unless pid.nil?
    puts "Already running as #{pid}."
    return 2
  end

  launcher_data = load_launcher_data

  pid = fork { execute launcher_data['launcher_main'] }

  Process.detach pid
  save_pid pid
  puts "Started as #{pid}."
  return 0
end

# Stop command
def stop
  pid = load_pid

  if pid.nil?
    puts 'Not running.'
    return 0
  else
    Process.kill Signal.list['TERM'], pid
    wait_stopped pid
    return 0
  end
end

# Status command
def status
  pid = load_pid

  if pid.nil?
    puts 'Not running.'
    return 0
  else
    puts "Running as #{pid}."
    return 1
  end
end

# Restart Command
def restart
  stop
  start
end

Dir.chdir @base_dir

exit case @command
when 'start'
  start
when 'stop'
  stop
when 'restart'
  restart
when 'status'
  status
else
  puts "Unknown Command: #{@command}!"
  2
end

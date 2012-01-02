#\ -p 8080
require 'rubygems'
require 'bundler'
require 'sinatra'

require 'src/main/ruby/main_app'
set :run, false
set :environment, :development
run Sinatra::Application

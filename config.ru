#\ -p 8080
require 'rubygems'
require 'bundler'
require 'sinatra'

$source_root = "src/main/galaxy/ruby/"
$resource_root = "src/main/galaxy/"

require $source_root + 'main_app'

set :run, false
set :environment, :development
run Sinatra::Application

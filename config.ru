#\ -p 8080
require 'rubygems'
require 'bundler'
require 'sinatra'

$source_root = "src/main/ruby/"
$resource_root = ""

require $source_root + 'main_app'

set :run, false
set :environment, :development
run Sinatra::Application

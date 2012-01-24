#\ -p ${admin.production.port}
require 'rubygems'
require 'bundler'
require 'sinatra'

$source_root = "${admin.production.ruby}"
$resource_root = "${admin.production.root}"

require $source_root + 'main_app'

set :run, false
set :environment, ${admin.production.environment}
run Sinatra::Application

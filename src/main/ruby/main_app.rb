class MainApp
  require 'rubygems'
  require 'bundler'
  require 'sinatra'
  require 'haml'
  require 'sass'

  get '/' do
    @title = "Hello"
    @css = ""
    @include = ""
    haml :index
  end
end

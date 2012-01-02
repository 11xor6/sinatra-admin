class MainApp
  require 'rubygems'
  require 'bundler'
  require 'sinatra'             # http://www.sinatrarb.com/documentation
  require 'haml'                # http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html
  require 'sass'                # http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html
  require 'sinatra/ratpack'     # http://rubydoc.info/github/zeke/ratpack/master/Sinatra/Ratpack
  require 'sinatra/content_for' # https://github.com/foca/sinatra-content-for

  get '/' do
    content_for :css do
      stylesheet_link_tag 'style'
    end
    @title = "Hello"

    @include = ""
    haml :index
  end

  get '/stylesheets/style.css' do
    scss :style
  end
end

class MainApp
  require 'rubygems'
  require 'bundler'

  # Gems
  require 'sinatra'                 # http://www.sinatrarb.com/documentation
  require 'haml'                    # http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html
  require 'sass'                    # http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html
  require 'sinatra/ratpack'         # http://rubydoc.info/github/zeke/ratpack/master/Sinatra/Ratpack
  require 'sinatra/advanced_routes' #https://github.com/rkh/sinatra-advanced-routes
  require 'sinatra/content_for'     # https://github.com/foca/sinatra-content-for
  require 'json/pure'               # http://flori.github.com/json/doc/index.html
  require 'json/add/core'           # ^^^ Same ^^^
  require 'net/http'                # http://ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/Net/HTTP.html


  # Local includes
  require $source_root + 'lib/main_module'
  require $source_root + 'lib/route_pair'


  # Debug
  require 'pp'


  # Template helpers
  def MainApp::set_header_title(title)
    @@header_title = title
  end

  def MainApp::get_header_title
    @@header_title
  end

  def MainApp::set_window_title(title)
    @@window_title = title
  end

  def MainApp::get_window_title
    @@window_title
  end


  # Initialization
  MainApp::set_header_title "InformedNess"
  MainApp::set_window_title "InformedNess"
  extend MainModule


  # Pages
  require $source_root + 'root_page'


  # Global pages
  get '/stylesheets/style.css' do
    scss :style
  end

end

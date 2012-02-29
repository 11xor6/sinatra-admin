module MainModule
  @@routes = Hash.new

  def MainModule.parse_config
    file = File.new($resource_root + 'config.json')
    mod_time = file.mtime.to_i
    file.close

    puts "Checking for updated config old: #{@mod_time} new: #{mod_time}"

    # If the config has already been loaded and it hasn't changed then return nil
    if !@mod_time.nil? && @mod_time >= mod_time
      return nil
    end

    @mod_time = mod_time
    JSON.parse open($resource_root + 'config.json').readlines.join " "
  end

  before do
    MainModule.add_tools
  end

  def MainModule.add_tools

    config = parse_config
    if config.nil?
      # Config hasn't changed; nothing to do.
      return
    end

    # We need to unregister all the routes if the config has changed.
    @@routes.each_value do |route|
      route.deactivate
    end
    @@routes.clear

    register_tools(config["config"]["tools"])

    # Add the root page
    root_page = {"path" => "/", "name" => "Home", "type" => "inline", "url" => "/", "methods" => ["GET"]};
    config["config"]["tools"].unshift root_page

    @@config = config
  end

  def MainModule.get_config
    @@config
  end

  def self.register_tools(tools, depth = 0)
    tools.each do |tool|

      case tool["type"].downcase
        when "menu" :
          register_tools tool["items"]


        when "iframe" :
          generate_iframe_route tool


        when "inline" :
          if tool["methods"].include?("ALL")
            methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
          else
            methods = tool["methods"]
          end

          methods.each do |method|
            generate_inline_route method, tool
          end


        else
          # Unknown type.
          throw "unknown type"
      end

    end

  end

  def MainModule.generate_iframe_route(tool)
    path = generalize_path(tool["path"])

    route = get path do
      haml :iframe, :locals => {:url => tool["url"]}
    end

    @@routes.store RoutePair.new("get", path), route
  end

  def MainModule.generate_inline_route(method, tool)
    path = tool["path"]
    url = tool["url"]
    styles = tool["styles"]

    case method.downcase
      when "get"
        route = get path do
          query = MainModule.generate_query({:params => URI.escape(params.to_json), :from => "admin"})
          uri = URI(url + query)
          pp uri
          res = Net::HTTP.get_response(uri)

          haml :inline, :locals => {:body => res.body, :styles => styles}
        end
      when "post", "put", "delete", "head"
        route = post path do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end

      else
        # Here we are dynamically generate a routes for the unknown method.
        # This will probably throw an exception if the method doesn't exist.
        route = this.method(method.downcase!.to_sym).call tool["path"] do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end
    end
    @@routes.store RoutePair.new(method, path), route

  end

  def MainModule.retrieve_inline_body(url, params, method)
    uri = URI(url)
    res = Net::HTTP.post_form(uri, {'from' => 'admin', 'method' => method, 'params' => URI.escape(params.to_json)})

    res.body
  end

  def MainModule.generate_query(params)
    query = ""
    params.each_pair do |key, value|
      if query == ""
        query = "?"
      else
        query += "&"
      end
      query += URI.escape(key.to_s) + "=" + URI.escape(value.to_s)
    end

    query
  end

  def MainModule.generalize_path(path)
    if path.end_with?("/?*")
      # Do nothing.
    elsif path.end_with?("/?")
      path += "*"
    elsif path.end_with?("/")
      path += "?*"
    else
      path += "/?*"
    end
    path
  end

end

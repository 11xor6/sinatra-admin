module MainModule
  @@routes = Hash.new

  def MainModule.parse_config
    mod_time = File.mtime($resource_root + 'config.json').to_i

    # If the config has already been loaded and it hasn't changed then return nil
    if @mod_time.nil?
      @mod_time = mod_time
    elsif @mod_time <= mod_time
      return nil
    end

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
    NavItem::clear_items

    config["config"]["tools"].each do |tool|

      type = tool["type"]
      methods = tool["methods"]
      if type == "iframe"
        # iframes only implement GET as there is no need to register anything else.
        methods = ["GET"]
      elsif methods.include?("ALL")
        methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
      end

      # Add this item to the menu.
      NavItem::add_item NavItem.new(tool["path"], tool["name"])


      # Generate default route(s) for this tool
      methods.each do |method|

        case type.downcase
          when "iframe"
            # Load the url in an iframe and forget about it.
            generate_iframe_route method, tool
          when "inline"
            # Designed external page to work seamlessly within the framework.
            generate_inline_route method, tool
          else
            throw "unknown tool type"
        end

      end
    end
  end

  def MainModule.generate_iframe_route(method, tool)
    path = generalize_path(tool["path"])

    # This can all be dynamically generated (see the else), but I include it here for clarity.
    case method.downcase
      when "get"
        route = get path do
          haml :iframe, :locals => {:url => tool["url"]}
        end
      else
        throw "Methods other than 'GET' are not supported for iframes"
    end

    @@routes.store RoutePair.new(method, path), route
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
          res = Net::HTTP.get_response(uri)

          haml :inline, :locals => {:body => res.body, :styles => styles}
        end
      when "post"
        route = post path do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end
      when "put"
        route = put path do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end
      when "delete"
        route = put path do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end
      when "head"
        route = put path do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end

      else
        # Here we are dynamically generate a routes for the unknown method.
        # This will probably throw an exception if the method doesn't exist.
        this.method(method.downcase!.to_sym).call tool["path"] do
          body = MainModule.retrieve_inline_body(url, params, method)

          haml :inline, :locals => {:body => body, :styles => styles}
        end
    end
    @@routes.store RoutePair.new(method, path), route

  end

  def MainModule.retrieve_inline_body(url, params, method)
    uri = URI(url)
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data('from' => 'admin', 'method' => method, 'params' => URI.escape(params.to_json))

    res = Net::HTTP.start("localhost", 80) do |http|
      http.request(req)
    end
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

class RootPage

  NavItem::add_static_item NavItem.new("/", "Home")

  get '/' do
    haml :index
  end
end

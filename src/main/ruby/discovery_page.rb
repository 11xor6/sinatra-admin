class DiscoveryPage
  NavItem::add_item NavItem.new("/discovery", "Discovery Status")

  MainApp::set_window_title "Discovery Status"

  get '/discovery' do
    haml :"discovery/discovery"
  end

end

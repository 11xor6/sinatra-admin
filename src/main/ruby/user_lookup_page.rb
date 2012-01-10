class UserLookupPage

  NavItem::add_item NavItem.new("/user", "User Lookup")
  MainApp::set_window_title "User Lookup"


  get '/user_foo_bar' do
    haml :"user/lookup_form"
  end


  get '/user_foo_bar/:environment/:id' do
    @id = params[:id]
    @environment = params[:environment]
    @action = "/user"

    ness_disco = NessDiscovery.new(@environment, false)
    uri = ness_disco.convert_service_uri("srvc://user/account/loadById?id=904955")
    json = ness_disco.make_service_call uri

    pp json

    @user = json[json.keys[0]]

    pp @user

    haml :"user/lookup"
  end

  post '/user' do
    @id = params[:id]
    @environment = params[:environment]

    haml :"user/lookup"
  end



end

require 'json'

class App < Sinatra::Base
  get "/" do
    if params[:agency_id] or params[:service_id] or params[:tag]
      c = Client.new
      @url = c.get_accounts(params).uri.to_str
    end
    erb :index
  end
  
  get "/test" do
    erb :test
  end
end

class Client < Weary::Client
  domain "http://registry.usa.gov"
    
  get :get_accounts, "/accounts.json" do |resource|
    resource.optional :agency_id, :service_id, :tag
  end
end
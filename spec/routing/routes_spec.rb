require 'spec_helper'

describe "routing to home page" do 
	it "routes root to venues#index" do
		{:get => "/"}.should route_to(
			:controller => "venues",
			:action => "index"
		)
	end
end
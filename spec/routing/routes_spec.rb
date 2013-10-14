require 'spec_helper'

describe "routing to home page" do 
	it "routes root to root#root" do
		{:get => "/"}.should route_to(
			:controller => "root",
			:action => "root"
		)
	end
end
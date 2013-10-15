describe VenuesController do 
	describe "GET #index" do 
		it "accepts venue_lat, venue_long and radius params" do

		end

		it "responds with an array of venues" do

		end
	end

	describe "venues#show" do 
		it "accepts a venue ID" do

		end

		it "returns a venue hash when given a valid ID" do 
			get :show, :id => "43c12ef9f964a520392d1fe3"

			response.status.should_equal 200
			response.instance_of?(Hash).should be_true
			
			response[:title].should_equal "Velo Rouge Cafe" # is this subject to change??
		end

		it "returns a 404 error when ID is not valid" do 
			get :show, :id => "hello"

			response.status.should_equal 404
		end
	end
end
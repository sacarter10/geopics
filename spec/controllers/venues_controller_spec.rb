describe VenuesController do 

	describe "GET #index" do 
		before :each do 
			get :index, { venue_lat: -33.8, venue_lng: 151.21, radius: 10000 } 
		end

		it "responds successfully to a valid request" do 
			response.should be_success
			response.status.should be(200)
		end

		it "calls Venue.find_nearby" do 
			Venue.should_receive(:find_nearby)
		end
	end

	describe "GET #show" do 
		describe "when passed a valid ID" do 
			before :each do 
				get :show, :id => "43c12ef9f964a520392d1fe3"
			end

			it "responds successfully" do
				response.should be_success
				response.status.should be(200)
			end

			it "calls Venue.find" do 
				Venue.should_receive(:find)
			end
		end

		describe "when ID is not valid" do 

			it "returns an error" do 
				get :show, :id => "hello"

				response.status.should be(404)
			end
		end
	end
end
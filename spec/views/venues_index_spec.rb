describe "root/root" do
	describe "home page" do 
		it "should have form with lat, long, radius inputs" do 
			render 
			response.should have_content("Latitude")
			response.should have_content("Longitude")
			response.should have_content("Search radius")
		end
	end
end
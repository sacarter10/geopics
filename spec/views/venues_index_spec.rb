describe "layouts/application" do
	describe "navbar" do 
		it "should have lat and long inputs" do 
			render 
			response.should have_content("Latitude")
			response.should have_content("Longitude")
		end
	end
end
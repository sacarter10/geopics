describe "venue information and thumbnails" do 
	describe "when a marker is clicked on" do
		before each do 
			visit root_path
			fill_in 'Latitude', :with => '34.05'
			fill_in 'Longitude', :with => '118.25'
			fill_in 'search_radius', :with => '1000'
			click_button 'Search'
		end

		xit "should display venue name" do 
			# click on a marker
			# page should_contain(marker's title)
		end

		xit "should display thumbnails if venue has pictures" do
			# click on a marker
		end

		xit "should not display thumbnails if venue has no pictures" do
			# click on a marker with no pictures
		end
	end

	describe "when other parts of the map are clicked on" do
		xit "should not do anything" do

		end
	end
end
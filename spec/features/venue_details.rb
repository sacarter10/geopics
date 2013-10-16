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
			# page should_contain(marker's title)
		end

		xit "should display thumbnails if venue has pictures" do
			# click on a marker
			# find('#venue-details').should have_selector('img')
		end

		xit "should not display thumbnails if venue has no pictures" do
			# click on a marker with no pictures
			# find('#venue-details').should_not have_selector('img')
			# find('#venue-details').should have_content('No images found')
		end
	end

	describe "when other parts of the map are clicked on" do
		xit "should not display any venue information" do
			# click somewhere else
			
		end
	end
end
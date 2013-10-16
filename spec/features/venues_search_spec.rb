describe "when the user searches for venues", :js => true do 
	describe "when search inputs are not valid" do
		it "displays invalid search error" do
			visit root_path
			fill_in 'Latitude', :with => 'hello'
			fill_in 'Longitude', :with => '64.5'
			fill_in 'search_radius', :with => '1000'
			click_button 'Search'

			page.should have_content('Invalid search inputs')
		end
	end

	describe "when no venues are found" do 
		it "displays no venues found error" do
			visit root_path
			fill_in 'Latitude', :with => '1'
			fill_in 'Longitude', :with => '160'
			fill_in 'search_radius', :with => '1'
			click_button 'Search'

			find('#errors').should have_content('No venues found')
		end
	end

	describe "when venues are found" do
		it "does not display an error message" do
			visit root_path
			fill_in 'Latitude', :with => '34.05'
			fill_in 'Longitude', :with => '118.25'
			fill_in 'search_radius', :with => '10000'
			click_button 'Search'

			page.should_not have_content('No venues found')
			page.should_not have_content('Invalid search inputs')
			page.should_not have_content('Something has gone wrong...')
		end
	end
end
describe "venue feed" do
	before :each do 
		visit root_path
		# click on a marker...
	end

	describe "before feed button has been clicked on" do
		it "does not display feed modal" do
			page.should_not have_content("Pictures from")
		end
	end

	describe "when feed button is clicked on" do
		xit "displays a modal" do
			page.should have_content("Pictures from")
		end

		xit "displays pictures" do
			page.should have_tag('img')
		end
	end
end
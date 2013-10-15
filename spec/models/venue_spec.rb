require 'spec_helper'

describe Venue do
  describe "initialize" do 
    it "takes hash of attributes and creates a new Venue object" do
      venue = Venue.new(name: "Cool Venue", url: 'www.coffee.com')

      venue.instance_of?(Venue).should be_true
    end

    it "sets name" do 
      venue = Venue.new(name: "Cool Venue", url: 'www.coffee.com')

      venue.name.should_equal "Cool Venue"
    end
  end

  describe "self.find" do 
    it "return a hash of venue data given a valid id" do 
      venue = Venue.find("43c12ef9f964a520392d1fe3")
      venue['name']
    end
  end

  describe "self.find_nearby" do 
  	it "returns nil when no venues found" do
  		Venue.find_nearby( { :venue_lat => 1,
  			:venue_lng => 160,
  			:radius => 1 
  			}).should be_nil
  	end

  	it "returns an array of hashes when venues are found" do
  		response = Venue.find_nearby({
  			:venue_lat => 37.48,
  			:venue_lng => -122.34,
  			:radius => 5000 
  			})

      response.instance_of?(Array).should be_true
      response.all? {|item| item.instance_of?(Hash)}.should be_true
  	end
  end

  describe "self.valid_venue_query?" do 
    it "returns false if a parameter is missing" do 
      Venue.valid_venue_query?( { :venue_lat => 37.48,
        :venue_lng => 160
        }).should be_false

      Venue.valid_venue_query?( { :venue_lat => 37.48,
        :radius => 10 
        }).should be_false
    end

    it "returns false if latitude or longitude is not with allowed range" do
      Venue.valid_venue_query?( { :venue_lat => 37.48,
        :venue_lng => 300, 
        :radius => 10
        }).should be_false

      Venue.valid_venue_query?( { :venue_lat => -130,
        :venue_lng => 29.5,
        :radius => 10 
        }).should be_false
    end

    it "returns false if radius is not a positive number" do 
      Venue.valid_venue_query?({
        :venue_lat => 35.68,
        :venue_lng => 139.69,
        :radius => -500
        }).should be_false

      Venue.valid_venue_query?({
        :venue_lat => 35.68,
        :venue_lng => 139.69,
        :radius => 0
        }).should be_false
    end

    it "returns true with valid parameters" do
      Venue.valid_venue_query?({
        :venue_lat => 37.48,
        :venue_lng => -122.34,
        :radius => 5000 
        }).should be_true 

      Venue.valid_venue_query?({
        :venue_lat => 35.68,
        :venue_lng => 139.69,
        :radius => 500
        }).should be_true
    end

  end

  describe "fetch_pictures" do

  end
end

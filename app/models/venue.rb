require 'addressable/uri'
require 'rest-client'

class Venue < ActiveRecord::Base
	attr_accessor :id, :name, :contact, :location, :pictures

	def self.find_nearby(venues_params)
		uri = Addressable::URI.new({
			scheme: "https",
			host: "api.foursquare.com",
			path: "/v2/venues/search",
			query_values: {
				ll: "#{venues_params[:venue_lat]},#{venues_params[:venue_lng]}",
				radius: venues_params[:radius],
				client_id: ENV['FOURSQUARE_ID'],
				client_secret: ENV['FOURSQUARE_SECRET'],
				v: 20131013
			}
		}).to_s

		response = JSON.parse(RestClient.get(uri))
		venue_array = response["response"]["venues"]
		
		venue_array.empty? ? nil : venue_array 
	end

	def self.valid_venue_query?(venues_params)
		begin
			lat = Float(venues_params[:venue_lat])
			lng = Float(venues_params[:venue_lng])
			radius = Float(venues_params[:radius])
		rescue
			return false
		end

		((-90..90).include?(lat) && (-180..180).include?(lng) && (1..400800).include?(radius))
	end

	def self.find(venue_id)
		p "the id is #{venue_id}"

		uri = Addressable::URI.new({
			scheme: "https",
			host: "api.foursquare.com",
			path: "/v2/venues/#{venue_id}",
			query_values: {
				client_id: ENV['FOURSQUARE_ID'],
				client_secret: ENV['FOURSQUARE_SECRET'],
				v: 20131013
			}
		}).to_s
		p "the uri is #{uri}"
		response = RestClient.get(uri)

		venue = JSON.parse(response)
		venue["response"]["venue"]
	end

	def self.fetch_pictures(venue)
		uri = Addressable::URI.new({
			scheme: "https",
			host: "api.instagram.com",
			path: "/v1/media/search",
			query_values: {
				lat: venue["location"]["lat"],
				lng: venue["location"]["lng"],
				distance: 20, # is 20 m very far?
				client_id: ENV['INSTAGRAM_ID'],
				client_secret: ENV['INSTAGRAM_SECRET'],
				v: 20131013
			}
		}).to_s

		pictures = RestClient.get(uri)
	end
end

require 'addressable/uri'
require 'rest-client'

class Venue < ActiveRecord::Base
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
end

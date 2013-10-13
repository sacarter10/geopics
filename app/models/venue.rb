require 'addressable/uri'
require 'rest-client'

class Venue < ActiveRecord::Base
	def self.find_nearby(venues_params)
		p venues_params
		uri = Addressable::URI.new({
			scheme: "http",
			host: "api.foursquare.com",
			path: "/v2/venues/explore",
			query_values: {
				ll: "#{venues_params[:venue_lat]},#{venues_params[:venue_long]}",
				radius: venues_params[:radius],
				client_id: ENV['FOURSQUARE_ID'],
				client_secret: ENV['FOURSQUARE_SECRET'],
				v: 20131013
			}
		}).to_s

		response = RestClient.get(uri)
		p response
	end
end

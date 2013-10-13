require 'addressable/uri'
require 'rest-client'

class Venue < ActiveRecord::Base
	def self.nearby_venues(lat, long, radius)
		uri = Addressable::Uri.new({
			host: "api.foursquare.com",
			path: "/v2/venues/explore",
			parameters: {
				ll: "#{lat},#{long}",
				radius: radius
			}
		})

		response = RestClient.get(uri)
		p response
	end
end

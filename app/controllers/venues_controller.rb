class VenuesController < ApplicationController
	def index
		@venues = Venue.find_nearby(venues_params)

		render :json => @venues
	end

	def show
		render :text => "hello"
	end

	def venues_params
		params.permit(:venue_lat, :venue_lng, :radius)
	end
end

class VenuesController < ApplicationController
	def index
		if !Venue.valid_venue_query?(venues_params)
			render :text => "Invalid search inputs!", :status => 422
		else
			@venues = Venue.find_nearby(venues_params)
			if @venues
				render :json => @venues
			else
				render :text => "No venues found near that location!", :status => 404
			end
		end
	end

	def show
		@venue = Venue.find(venues_params[:id])
		@venue['pictures'] = Venue.fetch_pictures(@venue['location']['lat'], @venue['location']['lng'], 20) 

		render :json => @venue
	end

	private
	def venues_params
		params.permit(:venue_lat, :venue_lng, :radius, :id)
	end
end

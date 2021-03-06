class VenuesController < ApplicationController
	def index
		if !Venue.valid_venue_query?(venues_params)
			render :text => "Invalid search inputs!", :status => 422
		else
			@venues = Venue.find_nearby(venues_params)
			
			render :json => @venues
		end
	end

	def show
		@venue = Venue.find(venues_params[:id])

		if @venue
			@venue['pictures'] = Venue.fetch_pictures(@venue['location']['lat'], 
					@venue['location']['lng'], 20) 
			render :json => @venue
		else 
			render :text => "Venue not found.", :status => 404
		end
	end

	private
	def venues_params
		params.permit(:venue_lat, :venue_lng, :radius, :id)
	end
end

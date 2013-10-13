# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

	$('#search-button').click (event) -> 
		event.preventDefault()
		console.log ENV[FOURSQUARE_ID]
		lat = $("#venue_lat").val()
		long = $("#venue_long").val()
		radius = $("search_radius").val()
		# raise errors maybe! 
		$.ajax
			url: "http://api.foursquare.com/v2/venues/explore"
			data: 
				ll: "#{lat},#{long}"
				radius: radius
			type: "get"
			success: (response) ->
				console.log response
			error: (response) ->
				console.log response
		

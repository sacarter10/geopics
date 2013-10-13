# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

	$('#search-button').click (event) -> 
		event.preventDefault()

		lat = $("#venue_lat").val()
		long = $("#venue_long").val()
		radius = $("#search_radius").val() 
		$.ajax
			url: "/venues/by_location"
			data: 
				venue_lat: lat
				venue_long: long
				radius: radius
			type: "get"
			success: (response) ->
				console.log response
			error: (response) ->
				console.log response
		

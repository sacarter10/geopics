# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


loadMap = (lat, lng) ->
	mapOptions =
    center: new google.maps.LatLng(lat, lng)
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

markVenues = (venues, map) ->
	for venue in venues
 		marker = new google.maps.Marker
    	position: new google.maps.LatLng(venue["location"]["lat"], venue["location"]["lng"])
    	map: map
    	title: venue["name"]

    google.maps.event.addListener(marker, 'click', venueClick.bind(null, venue['id']))

venueClick = (venueId) ->
  console.log venueId

$ ->
  loadMap(37.48, -122.24)
  $("#search-button").click (event) ->
    event.preventDefault()
    lat = $("#venue_lat").val()
    lng = $("#venue_lng").val()
    
    $.ajax
      url: "/venues/by_location"
      data:
        venue_lat: lat
        venue_lng: lng
        radius: $("#search_radius").val()
      type: "get"

      error: (jqXHR, status, errorThrown) ->
        if errorThrown == "Internal Server Error"
          $('#errors').html("Something has gone wrong...") 
        else
          $('#errors').html(jqXHR['responseText'])

      success: (response, status, jqXHR) ->
        $('#errors').empty()
        map = loadMap(lat, lng)
        markVenues(response, map)







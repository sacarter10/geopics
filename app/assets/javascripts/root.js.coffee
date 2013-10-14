# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


loadMap = (lat, lng) ->
	mapOptions =
    center: new google.maps.LatLng(lat, lng)
    zoom: 12
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

markVenues = (venues, map) ->
	for venue in venues
 		marker = new google.maps.Marker
    	position: new google.maps.LatLng(venue["location"]["lat"], venue["location"]["lng"])
    	map: map
    	title: venue["name"]	

$ ->
  loadMap(37.48, -122.24)
  $("#search-button").click (event) ->
    event.preventDefault()
    lat = $("#venue_lat").val()
    lng = $("#venue_lng").val()
    map = loadMap(lat, lng)
    $.ajax
      url: "/venues/by_location"
      data:
        venue_lat: lat
        venue_lng: lng
        radius: $("#search_radius").val()
      type: "get"

      error: (jqXHR, status, errorThrown) ->
        console.log status

      success: (response, status, jqXHR) ->
        markVenues(response, map)







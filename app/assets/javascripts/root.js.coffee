# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

displayVenue = (venue_id) ->
  console.log "displaying venue #{venue_id}"
  $.ajax
      url: "/venues/#{venue_id}"
      type: "get"

      error: (jqXHR, status, errorThrown) ->
        if errorThrown == "Internal Server Error"
          $('#errors').html("Something has gone wrong...") 
        else
          $('#errors').html(jqXHR['responseText'])

      success: (response, status, jqXHR) ->
        $('#errors').empty()
        console.log "here we are"
        $('#venue-detail').html(JST['venue_detail']({venue: response}))
        $("#feed-button").unbind('click', pictureCarousel.bind(response.pictures)) # remove any existing listeners
        $("#feed-button").click(pictureCarousel.bind(response.pictures)) 

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

    google.maps.event.addListener(marker, 'click', displayVenue.bind(null, venue['id']))

pictureCarousel = (pictures) -> 
    console.log('hey')
    event.preventDefault()
    $('#picture-modal').modal()
    $('#picture-carousel').carousel()


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







displayVenue = (venue_id) ->
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
        $('#venue-detail').css('visibility', 'visible')
        $('#venue-detail').html(JST['venue_detail']({venue: response}))
        $("#feed-button").unbind('click', pictureCarousel.bind(response.pictures)) # remove any existing listeners
        $("#feed-button").click(pictureCarousel.bind(response.pictures)) 

loadMap = (lat, lng) ->
  $('#venue-detail').css('visibility', 'hidden')
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
        if response.length is 0
          $('#errors').html("No venues found near that location.")
        map = loadMap(lat, lng)
        markVenues(response, map)







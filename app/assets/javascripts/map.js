function BrackMap(coords) {
  this.lat = coords.latitude
  this.lng = coords.longitude
  this.latLng = `${coords.latitude},${coords.longitude}`
  this.center = {lat: coords.latitude, lng: coords.longitude}
  this.image = {
    url: 'https://mississippistateparks.reserveamerica.com/images/maps/mm_20_chosen.png',
  }
}

BrackMap.drawMap = function(coords) {
  // setup map instance variables
  brackMap = new BrackMap(coords)
  // add map area and center
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: brackMap.center
  });
  // create search box and link it to the UI element
  var input = document.getElementById('pac-input')
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  searchBoxListener(searchBox)
  // add users current location and marker
  var userLatLng = new google.maps.LatLng(brackMap.lat, brackMap.lng);
  var userMarker = new google.maps.Marker({
    position: userLatLng,
    map: map,
    animation: google.maps.Animation.DROP,
    icon: brackMap.image
  })
  currentCenter.push(userMarker)
  // add markers for bike rack's near user center
  addMarkers(brackMap.latLng)
}

function clearCurrentMarkers() {
  $(".rack").remove()
  currentCenter.forEach(function(marker){
    marker.setMap(null)
  })
  currentCenter = []
  brackMarkers.forEach(function(marker) {
    marker.setMap(null)
  })
  brackMarkers = []
}

function searchBoxListener(searchBox) {
  searchBox.addListener('places_changed', function(){
    // get location from search
    var places = searchBox.getPlaces();
    if (places.length == 0) { return; }
    var place = places[0]
    if (!place.geometry) {
      console.log("Returned place contains no geometry");
      return;
    }
    // clear out old markers
    clearCurrentMarkers()
    // how to clear current location marker?
    // or maybe just remove current markers
    // re-add using addMarkers?
    var latLng = place.geometry.location
    var strngLatLng = `${latLng.lat()},${latLng.lng()}`
    var resultImage = {
      url: 'https://mississippistateparks.reserveamerica.com/images/maps/mm_20_chosen.png'
    }
    var userMarker = new google.maps.Marker({
      position: latLng,
      map: map,
      animation: google.maps.Animation.DROP,
      icon: 'https://mississippistateparks.reserveamerica.com/images/maps/mm_20_chosen.png'
    })
    map.panTo(latLng);
    addMarkers(strngLatLng)
  })
}

function setMapZoom(distance) {
  var dynaZoom = Math.round((-7 * distance) + 19)
  if (dynaZoom < 10) { dynaZoom = 10 }
  map.setZoom(dynaZoom)
}

function addMarkers(latLng) {
  // get request to brack index api
  $.getJSON("https://brackr.herokuapp.com/api/v1/bracks", {latlng: latLng}, function(data){
    // for each bike rack...
    for (var i = 0; i < data.length; i++) {
      // save attributes for the marker
      // unfortunately we need to pull it out first like this
      var lat = data[i].lat
      var long = data[i].long
      var id = data[i].id
      var cross_streets = data[i].cross_streets
      var distance = data[i].distance
      var owner = data[i].owner

      // add marker for bike rack to the map
      var latLng = new google.maps.LatLng(lat, long);
      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        animation: google.maps.Animation.DROP,
        markerId: id,
        cross_streets: cross_streets,
        distance: distance,
        owner: owner
      })

      // save markers to global collection for later access
      brackMarkers.push(marker)
      // add listener to marker if clicked
      marker.addListener('click', function() {
        addRackInfoWindow(this)
      });

      // add rack to nearest rack index
      addRackToIndex(data[i].id, data[i].distance)

      if (i == data.length-1) {
        setMapZoom(distance)
      }
    }
  })
}

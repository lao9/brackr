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
    zoom: 18,
    center: brackMap.center
  });
  // add users current location and marker
  var userLatLng = new google.maps.LatLng(brackMap.lat, brackMap.lng);
  var userMarker = new google.maps.Marker({
    position: userLatLng,
    map: map,
    animation: google.maps.Animation.DROP,
    icon: brackMap.image
  })
  // add markers for bike rack's near user center
  addMarkers(brackMap.latLng)
}

function addMarkers(latLng) {
  // get request to brack index api
  $.getJSON("http://localhost:3000/api/v1/bracks", {latlng: latLng}, function(data){
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
    }
  })
}

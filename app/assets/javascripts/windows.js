function addRackInfoWindow(brackMarker) {
  closeAllInfoWindows()
  var newBrack = new Brack(brackMarker)
  map.panTo(newBrack.latLng);
  var contentString = newBrack.contentString();
  var infowindow = new google.maps.InfoWindow({
    content: contentString
  })
  infoWindows.push(infowindow);
  infowindow.open(map, brackMarker)
}

function closeAllInfoWindows() {
    for (var i=0; i<infoWindows.length; i++) {
      infoWindows[i].close();
    }
    infoWindows = [];
}

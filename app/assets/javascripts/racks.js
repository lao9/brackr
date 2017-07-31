
$(document).ready(function(){
  expandRackOptions()
})

function toggleRackIndex(){
  $('.racks-show').slideToggle(1000)
  $('.racks-hide').slideToggle(1000)
}

function expandRackOptions() {
  $('.racks-index').on('click', function(event){
    if ($(event.target).hasClass("rack")) {
      var brackId = $(event.target).data("id")
      refocusMap(brackId)
    }
    if ($(this).hasClass("racks-hide")) {
      toggleRackIndex()
      $("#map").animate({
        height: "-=120",
      }, 1000)
    } else {
      toggleRackIndex()
      $("#map").animate({
        height: "+=120"
      }, 1000)
    }
  })
}

function closeAllInfoWindows() {
    for (var i=0; i<infoWindows.length; i++) {
      infoWindows[i].close();
    }
    infoWindows = [];
}

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

function refocusMap(brackId) {
  var origMarker = brackMarkers.filter(function(v){
    return v["markerId"] == brackId;
  })[0]
  addRackInfoWindow(origMarker)
}

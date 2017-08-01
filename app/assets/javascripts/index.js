// define global map variables
var map;
var infoWindows = [];
var brackMarkers = [];
var currentCenter = [];

$(document).ready(function(){
  var path = window.location.pathname
  if (path === "/" || path === "/bracks") {
    geolocator()
    expandRackOptions()
  }
})

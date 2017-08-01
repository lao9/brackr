// define global map variables
var map;
var infoWindows = [];
var brackMarkers = [];
var currentCenter = [];

$(document).ready(function(){
  geolocator()
  expandRackOptions()
})

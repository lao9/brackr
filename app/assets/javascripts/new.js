BrackMap.drawMapForNewBrack = function(coords) {
  // setup map instance vars for a central location
  brackMap = new BrackMap(coords)
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 10,
    center: brackMap.center
  })
  var input = document.getElementById('pac-input')
  var searchBox = new google.maps.places.SearchBox(input);
  addNewBrackListener(searchBox)
}

function addNewBrackListener(searchBox) {
  searchBox.addListener('places_changed', function(){
    var searched = false

    clearCurrentMarkers()
    // get location from search
    var places = searchBox.getPlaces();
    if (places.length == 0) { return; }
    var place = places[0]
    if (!place.geometry) {
      console.log("Returned place contains no geometry");
      return;
    }
    // place center marker
    var latLng = place.geometry.location
    brackMap = new BrackMap({latitude: latLng.lat(), longitude: latLng.lng()})

    var userLatLng = new google.maps.LatLng(brackMap.lat, brackMap.lng);

    var userMarker = new google.maps.Marker({
      position: userLatLng,
      map: map,
      animation: google.maps.Animation.DROP,
      icon: brackMap.image,
      draggable: true,
      title: "Drag me!"
    })

    if (!searched) {
      moveToStepTwo()
      searched = true
    }

    currentCenter.push(userMarker)

    map.panTo(latLng)
    map.setZoom(18)
    // add marker drag listener
    google.maps.event.addListener(userMarker, 'dragend', function(event) {
      console.log(currentCenter[0].position.lat())
      console.log(currentCenter[0].position.lng())
      console.log('final position is '+event.latLng.lat()+' / '+event.latLng.lng());
    });

  })
}

function moveToStepTwo() {
  setTimeout(function(){
    $("h5").text("Drag bike rack pin to correct location on map")
    $("h5").fadeIn("slow", function() {
      $(this).toggleClass("highlight");
    });
  }, 1000)
  setTimeout(function(){
    $("#map").animate({
      height: "-=100"
    }, 700)
    $(".new-next").show()
  }, 2000)
  setTimeout(function () {
    $("h5").toggleClass("highlight");
    $("h5").toggleClass("unhighlight");
  }, 3000);
  $(".new-next").on('click', function(){
    console.log("Yay!")
    debugger
  })
}

function moveToStepThree() {
  
}

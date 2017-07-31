

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

function refocusMap(brackId) {
  console.log(`Brack ID ${brackId}`)

  closeAllInfoWindows()

  $.getJSON(`http://localhost:3000/api/v1/bracks/${brackId}`, function(data){

    var center = new google.maps.LatLng(data.lat, data.long);
    map.panTo(center);

    var contentString = `<div>SOME STUFF!</div>`

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    })

    infoWindows.push(infowindow);

    var marker = new google.maps.Marker({
      position: center,
      map: map,
      title: "Rack #1"
    });


    infowindow.open(map, marker)

    // add a listener too

  }).then(function(){
    console.log("You got got.")
  })
}

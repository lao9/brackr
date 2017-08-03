function geolocator() {
  addWaitingMessage()
  grabUserLocation()
  clearFlashMessage()
}

function addWaitingMessage() {
  $(".container:nth-child(2)").prepend(
    `<div class='alert waiting alert-warning'>
    <button type='button' class='close' data-dismiss='alert'>x</button>
    Waiting to obtain your location...
    </div>
    `)
}

function grabUserLocation() {
  navigator.geolocation.getCurrentPosition(showPosition, failureMessage, {
      maximumAge: Infinity,
      timeout:5000
  });
}

function failureMessage(error) {
  console.log(error)
  $(".waiting").removeClass("alert-warning")
  $(".waiting").addClass("alert-danger")
  var errorMessage = "Unable to obtain your current position! Using default location."
  $(".waiting").html(`<button type="button" class="close" data-dismiss="alert">x</button>\n${errorMessage}`)
  BrackMap.drawMap({latitude: 39.749598000000006, longitude: -105.0004297})
}

function showPosition(position) {
  var lat = position.coords.latitude
  var lng = position.coords.longitude

  var between_north_south_bounds = ((lat < 39.956119) && (lat > 39.596206))
  var between_east_west_bounds = ((lng > -105.268481) && (lng < -104.577716))

  if (between_north_south_bounds && between_east_west_bounds) {
    $(".waiting").removeClass("alert-warning")
    $(".waiting").addClass("alert-success")
    $(".waiting").html('<button type="button" class="close" data-dismiss="alert">x</button>\nSuccess!')
    BrackMap.drawMap(position.coords)
  } else {
    $(".waiting").html('<button type="button" class="close" data-dismiss="alert">x</button>\nLooks like youre not in Denver! Using default location.')
    BrackMap.drawMap({latitude: 39.749598000000006, longitude: -105.0004297})
  }
}

function clearFlashMessage () {
  setTimeout(function() {
          $('.alert').fadeOut('slow');
        }, 7000);
}

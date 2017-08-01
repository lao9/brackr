function geolocator() {
  addWaitingMessage()
  grabUserLocation()
}

function addWaitingMessage() {
  $(".container:nth-child(2)").prepend(
    `<div class='alert alert-warning'>
    <button type='button' class='close' data-dismiss='alert'>x</button>
    Waiting to obtain your location...
    </div>
    `)
}

function grabUserLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    failureMessage();
  }
}

function failureMessage() {
  $(".alert").removeClass("alert-warning")
  $(".alert").addClass("alert-danger")
  var errorMessage = "Geolocation is not supported by this browser."
  $(".alert").html(`<button type="button" class="close" data-dismiss="alert">x</button>\n${errorMessage}`)
  BrackMap.drawMap({latitude: 39.749598000000006, longitude: -105.0004297})
}

function showPosition(position) {
  $(".alert").removeClass("alert-warning")
  $(".alert").addClass("alert-success")
  $(".alert").html('<button type="button" class="close" data-dismiss="alert">x</button>\nSuccess!')
  BrackMap.drawMap(position.coords)
}

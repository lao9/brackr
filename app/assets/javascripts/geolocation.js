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
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    failureMessage();
  }
}

function failureMessage() {
  $(".waiting").removeClass("alert-warning")
  $(".waiting").addClass("alert-danger")
  var errorMessage = "Geolocation is not supported by this browser."
  $(".waiting").html(`<button type="button" class="close" data-dismiss="alert">x</button>\n${errorMessage}`)
  BrackMap.drawMap({latitude: 39.749598000000006, longitude: -105.0004297})
}

function showPosition(position) {
  $(".waiting").removeClass("alert-warning")
  $(".waiting").addClass("alert-success")
  $(".waiting").html('<button type="button" class="close" data-dismiss="alert">x</button>\nSuccess!')
  BrackMap.drawMap(position.coords)
}

function clearFlashMessage () {
  setTimeout(function() {
          $('.alert').fadeOut('slow');
        }, 5000);
}

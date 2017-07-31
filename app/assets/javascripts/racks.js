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

function refocusMap(brackId) {
  console.log(`Brack ID ${brackId}`)
}

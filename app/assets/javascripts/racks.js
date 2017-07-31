$(document).ready(function(){

  expandRackOptions()

})

function expandRackOptions() {
  $('.racks-index').on('click', function(event){
    if ($(this).hasClass("racks-hide")) {
      $('.racks-show').slideToggle(1000)
      $('.racks-hide').slideToggle(1000)
      $("#map").animate({
        height: "-=200",
      }, 1000)
    } else {
      $('.racks-hide').slideToggle(1000)
      $('.racks-show').slideToggle(1000)
      $("#map").animate({
        height: "+=200"
      }, 1000)
    }
  })
}

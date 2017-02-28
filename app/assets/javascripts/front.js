//= require jquery
//= require turbolinks

$(document).on('turbolinks:load', function(){

  var slides = $('.slideshow-image')
  var lastSlideIndex = slides.length-1
  var currentVisId = 0

  var nextSlide = function(){
    $( slides[currentVisId] ).hide()
    if(currentVisId == lastSlideIndex){
      currentVisId = 0
    } else {
      currentVisId += 1
    }
    $( slides[currentVisId] ).show()
  }

  $( slides[currentVisId] ).show()
  setInterval(function(){
    nextSlide()
  }, 5000)

  $('.sorting a').on('click', function(e){
    e.preventDefault()
    e.stopPropagation()

    var sortBy = $( e.target ).parent().data('sort')

    var $cont = $('.index-container')
    var $items = $cont.children('.box');

    $items.sort(function(a,b){
      var an = a.getAttribute('data-title');
      var bn = b.getAttribute('data-title');

        if(an > bn) {
          return 1;
        }
        if(an < bn) {
          return -1;
        }
        return 0;
    });
    $items.detach().appendTo($cont);
  })

})

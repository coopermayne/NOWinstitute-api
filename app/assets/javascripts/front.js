//= require jquery
//= require jquery.unveil
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

  $('img.lazy').unveil();

  $('#hamburger').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();
    console.log("clicked ham");

    $('nav').toggleClass('hide')
    $('#hamburger').toggleClass('hide')
    $('.magic-x').toggleClass('hide')
  })

  $('.magic-x').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    var action = $(e.target).data('action')

    if ( action === 'go back' ) {

      var storedRef = $('meta[name=previous-page]')
      if(storedRef.attr('content').match('localhost')){
        window.history.back()
      }else {
        var uu = window.location.href
        window.location = uu.substring(0, uu.lastIndexOf('/'))
      }

    } else if ( action == 'collapse menu') {
      $('nav').toggleClass('hide')
      $('#hamburger').toggleClass('hide')
      $('.magic-x').toggleClass('hide')
    }
  })

})

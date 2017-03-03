//= require jquery
//= require jquery.unveil
//= require jquery.photoswipe-global
//= require turbolinks

$(document).on('turbolinks:load', function(){
  console.log('load');

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

  $('.openable').on('click', function(e){
    var el = $(e.target);
    if(el.hasClass('openable')){
      if(el.hasClass('image-gallery')){ return; }
      el.toggleClass('closed')
    } else {
      el.parent().click()
    }
  })

  $('.image-gallery .title').on('click', function(e){
    $(e.target).parent().toggleClass('closed')
  })

  $('.gallery').photoSwipe(".slide", {
    isClickableElement: function(){
      return true;
    },
    arrowEl: true,
    timeToIdle: 2000,
    bgOpacity: 0.8,
    shareEl: false,

  }, {
    close: function(){
      console.log("close slideshow");
    }
  });

  $('.arrow-right').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()+300}, 800);
  })

  $('.arrow-left').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()-300}, 800);
  })

})

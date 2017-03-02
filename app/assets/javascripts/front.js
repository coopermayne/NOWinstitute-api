//= require jquery
//= require jquery.unveil
//= require turbolinks
//= require photoswipe

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

  $('.openable').on('click', function(e){
    var el = $(e.target);
    if(el.hasClass('openable')){
      el.toggleClass('closed')
    } else {
      el.parent().click()
    }
  })

  $('.picture').each(function(){
    var $pic     = $(this),
      getItems = function() {
        var items = [];
        $pic.find('a').each(function() {
          var $href   = $(this).attr('href'),
            $size   = $(this).data('size').split('x'),
              $width  = $size[0],
                $height = $size[1];

                var item = {
                  src : $href,
                  w   : $width,
                  h   : $height
                }

                items.push(item);
        });
        return items;
      }

      var items = getItems();
      console.log(items)
  })

  var $pswp = $('.pswp')[0];
  $pic.on('click', 'figure', function(event) {
    event.preventDefault();

    var $index = $(this).index();
    var options = {
      index: $index,
      bgOpacity: 0.7,
      showHideOpacity: true
    }

    var lightBox = new PhotoSwipe($pswp, PhotoSwipeUI_Default, items, options);
    lightBox.init();
  });

})

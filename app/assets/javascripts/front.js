//= require jquery
//= require jquery.unveil
//= require turbolinks

function wait(ms) {
  var start = Date.now(),
    now = start;
    while (now - start < ms) {
      now = Date.now();
    }
}
var waitTime = 20
$(document).on('turbolinks:click', function(){
  wait(waitTime)
  console.log("------------------------");
  console.log('click');
})
$(document).on('turbolinks:before-visit', function(){
  wait(waitTime)
  console.log('before-visit');
})
$(document).on('turbolinks:visit', function(){
  wait(waitTime)
  console.log('visit');
})
$(document).on('turbolinks:request-start ', function(){
  wait(waitTime)
  console.log('request-start ');
})
$(document).on('turbolinks:request-end', function(){
  wait(waitTime)
  console.log('request-end');
})
$(document).on('turbolinks:before-cache', function(){
  wait(waitTime)
  console.log('before-cache');
})
$(document).on('turbolinks:before-render', function(){
  wait(waitTime)
  console.log('before-render');
})
$(document).on('turbolinks:render', function(){
  wait(waitTime)
  console.log('render');
})

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
    console.log("CLICK X");

    var action = $(e.target).data('action')

    if ( action === 'go back' ) {

      var storedRef = $('meta[name=previous-page]')
      if(storedRef.attr('content').match('localhost')){
        window.history.back()
      }else {
        var uu = window.location.href
        var dest = uu.substring(0, uu.lastIndexOf('/'))
        //window.location = dest
        Turbolinks.visit(dest)
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

  //$('.gallery').photoSwipe(".slide", {
    //isClickableElement: function(){
      //return true;
    //},
    //arrowEl: true,
    //timeToIdle: 2000,
    //bgOpacity: 0.8,
    //shareEl: false,
    //history: false,

  //}, {
    //close: function(){
      //console.log("close slideshow");
    //},
    //destroy: function(){
      //console.log("destroy");
    //}
  //});

  $('.arrow-right').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()+300}, 800);
  })

  $('.arrow-left').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()-300}, 800);
  })


  var pswpElement = document.querySelectorAll('.pswp')[0];

  var items_b = [
    {
      src: 'https://placekitten.com/600/200',
      w: 600,
      h: 200
    },
  ];
  var items_a = [
    {
      src: 'https://placekitten.com/600/401',
      w: 600,
      h: 401
    },
    {
      src: 'https://placekitten.com/1200/900',
      w: 1200,
      h: 900
    }
  ];

  var options = {
    index: 0,
    history: false
  };

  var galleries = [
  ]

  $('.show-on-desktop .gallery').each(function(index){
    //create image arrays
    var els = $(this).children().map(function(index, item){
      return {
        src: $(this).data('original-src'),
        w: $(this).data('original-src-width'),
        h: $(this).data('original-src-height'),
        msrc: $(this).attr('src')
      }
    })

    galleries.push(new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, els, options))

    //bind click events 
    $(this).children().on('click', function(){
      galleries[index].init()
    });
  });

  //$('img.slide').on('click', function(){
    //gallery.init();
  //})

})

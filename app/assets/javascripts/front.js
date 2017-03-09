//= require jquery
//= require jquery.unveil
//= require turbolinks

$(document).on('page:change', function() {
  if (window._gaq != null) {
    return _gaq.push(['_trackPageview']);
  } else if (window.pageTracker != null) {
    return pageTracker._trackPageview();
  }
});

$(document).on('turbolinks:load', function(){
  console.log('load');

  if(isDesktop()){
    var el = $('.responsive-background').first();
    el.css('background-image', 'url(' + el.data('desktop') + ')');
  }

  $('.sorting-option-wrapper').on('click', function(e){
    var href = $(this).children().children().first().attr('href')
    if(window.location.pathname !== href){
      Turbolinks.visit(href)
    }
  })

  loadLazyCss()

  var slides = $('.slideshow-image')
  var lastSlideIndex = slides.length-1
  var currentVisId = 0
  var slideShowSpeed = 10000

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
  }, slideShowSpeed)

  //apply lazy load for images
  $('img.lazy').unveil();

  //mobile menu functionality
  $('#hamburger').on('click', function(e){
    e.preventDefault();
    e.stopPropagation();

    $('.menu-directive').toggleClass('contracted-menu')
    $('.menu-directive').toggleClass('cover')
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
        var dest = uu.substring(0, uu.lastIndexOf('/'))
        //window.location = dest
        Turbolinks.visit(dest)
      }

    } else if ( action == 'collapse menu') {
      $('.menu-directive').toggleClass('contracted-menu')
      $('.menu-directive').toggleClass('cover')
      $('#hamburger').toggleClass('hide')
      $('.magic-x').toggleClass('hide')
    }
  })

  $('.openable').on('click', function(e){
    var el = $(this);
    console.log(el);
    e.preventDefault()
    e.stopPropagation()

    el.toggleClass('closed')


  })

  $('.credits a').on('click', function(e){
    e.stopPropagation();
  })

  $('.image-gallery .title').on('click', function(e){
    $(e.target).parent().toggleClass('closed')
  })

  $('.arrow-right').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()+300}, 800);
  })

  $('.arrow-left').on('click', function(e){
    var gal = $(e.target).siblings('.gallery').first()
    $(gal).animate({scrollLeft: gal.scrollLeft()-300}, 800);
  })


  $('.gallery').each(function(index){
    //create image arrays
    var that = this
    //bind click events 
    $(this).children().on('click', function(){
      openPhotoSwipe(that);
    });
  });

  setTimeout(function(){
    loadDefferedEmbeds();
  }, 500)

  //hide unnec arrows
  $('.desktop-content .gallery').each(function(e){
    if ( !$(this).children().length ) {return;}

    var galleryWidth = $(this).width();
    var lastChildPosition = $(this).children().last().position().left + $(this).children().last().width();

    if ( lastChildPosition < galleryWidth  ){
      $(this).siblings().hide()
    }

  })


  //people index sorting

  $('.option-list-wrapper p').on('click', function(){
    var el = $(this)

    //manage display to user
    el.parent().siblings().each(function(){$(this).children().removeClass('selected')})
    el.addClass("selected")
    console.log(el.text());

    //manage filtering
    $('a.box').not('[data-is-leadership]').hide()

    //close mobile menu
    if( $('.menu-directive').hasClass('cover')){
      $('.menu-directive').toggleClass('cover')
      $('.menu-directive').toggleClass('contracted-menu')
      $('#hamburger').toggleClass('hide')
      $('.magic-x').toggleClass('hide')
    }
  })

})

var isDesktop = function(){
  return document.documentElement.clientWidth > 480
}


var loadDefferedEmbeds = function(){
  var vidDefer = document.getElementsByTagName('iframe');
  if (document.documentElement.clientWidth > 480 ){
    for (var i=0; i<vidDefer.length; i++) {
      if(vidDefer[i].getAttribute('data-src')) {
        vidDefer[i].setAttribute('src',vidDefer[i].getAttribute('data-src'));
      } 
    }
  } 
}

var openPhotoSwipe = function(gallery){
  var pswpElement = document.querySelectorAll('.pswp')[0];
  var options = {
    index: 0,
    history: false,
    shareButtons: [
      {id:'twitter', label:'Tweet', url:'https://twitter.com/intent/tweet?text={{text}}&url={{url}}'},
      {id:'download', label:'Download image', url:'{{raw_image_url}}', download:true}
    ],
  };

  var els = $(gallery).children().map(function(index, item){
    return {
      src: $(this).data('original-src'),
      w: $(this).data('original-src-width'),
      h: $(this).data('original-src-height'),
      msrc: $(this).attr('src')
    }
  })

  var g = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, els, options);
  g.init();
}

var loadLazyCss = function(){
  var photoswipcss = document.createElement('link');
  photoswipcss.rel = 'stylesheet';
  photoswipcss.href ="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/4.1.1/photoswipe.min.css";
  photoswipcss.type = 'text/css';
  var godefer = document.getElementsByTagName('link')[0];
  godefer.parentNode.insertBefore(photoswipcss, godefer);

  var theme = document.createElement('link');
  theme.rel = 'stylesheet';
  theme.href = "https://cdnjs.cloudflare.com/ajax/libs/photoswipe/4.1.1/default-skin/default-skin.min.css";
  theme.type = 'text/css';
  var godefer2 = document.getElementsByTagName('link')[0];
  godefer2.parentNode.insertBefore(theme, godefer2);
}

function wait(ms) {
  var start = Date.now(),
    now = start;
    while (now - start < ms) {
      now = Date.now();
    }
}
var waitTime = 0
//$(document).on('turbolinks:click', function(){
  //wait(waitTime)
  //console.log("------------------------");
  //console.log('click');
//})
//$(document).on('turbolinks:before-visit', function(){
  //wait(waitTime)
  //console.log('before-visit');
//})
//$(document).on('turbolinks:visit', function(){
  //wait(waitTime)
  //console.log('visit');
//})
//$(document).on('turbolinks:request-start ', function(){
  //wait(waitTime)
  //console.log('request-start ');
//})
//$(document).on('turbolinks:request-end', function(){
  //wait(waitTime)
  //console.log('request-end');
//})
//$(document).on('turbolinks:before-cache', function(){
  //wait(waitTime)
  //console.log('before-cache');
//})
//$(document).on('turbolinks:before-render', function(){
  //wait(waitTime)
  //console.log('before-render');
//})
//$(document).on('turbolinks:render', function(){
  //wait(waitTime)
  //console.log('render');
//})


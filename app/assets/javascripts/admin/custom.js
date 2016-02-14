// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
//

$(document).ready(function(){
  $('form').on('click', '.add_fields', function(event) {
    //add the form partial
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    //add trumbowyg
    applyTextBox($('textarea'))
    event.preventDefault();
  });

  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault();
  })

  $('.subtype input').on('change', function(a,b,c){
    var t_el = $(a.target)
    var isChecked=t_el.is(':checked')
    if(isChecked){
      //check all parent checkboxes...
      t_el.parents('.type').children('input:checkbox').prop("checked", true)
    }
  })
  $('.type input').on('change', function(a,b,c){
    var t_el = $(a.target)
    var isChecked=t_el.is(':checked')
    if(!isChecked){
      //uncheck kids
      t_el.siblings('.subtype').find('input:checkbox').prop("checked", false)
    }
  })

  $('.types').hide()
    $('.section'+$('.section select').val()).show()

  $('.section select').on('change', function(e){
    var el = $( e.target )
    $('.types').hide()
    $('.section'+el.val()).show()
  })

  applyTextBox($('textarea'))
})

var applyTextBox = function(jquery_el){
  jquery_el.trumbowyg({
    autogrow: true,
    fullscreenable: false,
    semantic: true,
    btns:[
      'viewHTML',
      '|', 'formatting',
      '|', 'btnGrp-design',
      '|', 'link',
      '|', 'btnGrp-lists',
      '|', 'horizontalRule'
    ]
  })
}
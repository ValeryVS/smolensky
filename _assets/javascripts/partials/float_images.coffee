floatImageModify = (el, className) ->
  el
    .removeClass(className)
    .wrap('<div class="'+className+'"/>')
  el.parent('.'+className)
    .width(el.width())
  if el.attr('alt') && el.attr('alt').length > 0
    el.parent('.'+className)
      .append('<div class="image-caption">'+el.attr('alt')+'</div>')

$(window).load ->
  $('.image_left').each ->
    floatImageModify($(@),'image_left')

  $('.image_right').each ->
    floatImageModify($(@),'image_right')

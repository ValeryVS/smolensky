# if $(role('screen-first-slider')).find('img').length > 0
#   $(role('screen')).prepend('<div class="screen_first__slider" role="screen-first-slider-generated"/>')

# sliderCont = $(role('screen-first-slider-generated'))

# $(role('screen-first-slider')).find('img').each ->
#   src = $(@).attr('src')
#   sliderCont.append('<div class="screen_first__slider-item" style="background-image: url('+src+')"/>')

# sliderCont.bxSlider
#   pager: false
#   nextText: ''
#   prevText: ''

$(role('screen-first-slider')).each ->
  url = $(@).find('img').eq(0).attr('src')
  $(@).parents(role('screen')).css('background-image','url('+url+')')

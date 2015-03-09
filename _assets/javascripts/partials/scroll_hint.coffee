if $(role('screen')).hasClass('screen') # if page = mainPage
  $('body').append('<div class="scroll-hint" role="scroll-hint" />')

@setScrollHintVisibility = ->
  if $(window).height() >= $(document).height() or $('body').hasClass '404_no_arrow'
    $(role('scroll-hint')).hide()
  else
    scrollTop =  $(window).scrollTop()
    if scrollTop >= 160
      $(role('scroll-hint')).hide()
    else
      if $(role('menu-main')).hasClass('active')
        $(role('scroll-hint')).hide()
      else
        $(role('scroll-hint')).show()
  return

setScrollHintVisibility()

$(window).on 'scroll', setScrollHintVisibility

if $(role('screen')).length > 0
  $('body').append('<div role="scroll-hint" class="scroll-hint-cont"><div class="scroll-hint" /></div>')
  $(role('scroll-hint')).click ->
    windowHeight = $(window).height()
    if typeof s isnt 'undefined'
      s.animateTo windowHeight
    else
      $("html,body").animate
        scrollTop: windowHeight
      , 1000
      false
    return

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

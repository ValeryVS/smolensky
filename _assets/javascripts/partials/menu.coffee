$('.social__menu__links').clone().addClass('mobile').attr('role','social-menu-links-sx').prependTo('body')

$(role('social-menu')).click ->
  $(@).toggleClass('active')
  $(role('page')).toggleClass('social-menu')
  $(role('social-menu-links-sx')).toggleClass('active')

menu = $(role('menu-main'))
menu.wrapInner('<div class="menu-main__content" role="menu-main-content" />')

$(role('menu-main-open')).click ->
  windowHeight = $(window).height()

  menu.toggleClass('active')
  $(this).toggleClass('active')
  $(role('header')).toggleClass('menu')

  if menu.hasClass('active')
    menu.height(windowHeight)
    $(role('scroll-hint')).hide()
  else
    menu.height(0)
    setScrollHintVisibility()

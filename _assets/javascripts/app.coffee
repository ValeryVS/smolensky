#= require jquery/dist/jquery.min.js
#= require nprogress/nprogress.js
#= require packery/dist/packery.pkgd.min.js
#= require skrollr/dist/skrollr.min.js

#= require initiates
#= require partials/scroll_hint
#= require partials/plans
#= require partials/slider
#= require partials/float_images
#= require partials/menu
#= require partials/login
#= require partials/map
#= require partials/footer

$(role('footer')).wrapInner('<div class="footer-main__content" />')

$('.about,.brand,.blog,.share-block,.recommend').wrap('<div class="wrap-bg" />')

$(role('block-bg-image')).each ->
  $(@).parent().css('background-image','url('+$(@).attr('src')+')')

$(role('screen-bg-image')).each ->
  $(@).parents(role('screen')).css('background-image','url('+$(@).attr('src')+')')

$(role('masonry')).find('.brick').each ->
  # check brick data
  brickData = $(@).data()

  # make brick size data integer
  if brickData.width
    brickData.width = parseInt(brickData.width)
  else
    brickData.width = 1
  if brickData.height
    brickData.height = parseInt(brickData.height)
  else
    brickData.height = 1

  # check brick info block data
  brickInfoData = $(@).find(role('brick-info')).data()
  if brickInfoData
    # compute bg position
    if brickInfoData.v is 'bottom'
      posV = 'top'
    else
      posV = 'bottom'
    if brickInfoData.h is 'left'
      posH = 'right'
    else
      posH = 'left'

    # compute bg size
    if brickData.width is 1
      height = brickData.height - 1
    else
      height = brickData.height
    if brickData.height is 1
      width = brickData.width - 1
    else
      width = brickData.width
  else
    posV = 'top'
    posH = 'left'
    height = brickData.height
    width = brickData.width

  # set brick bg-image-block
  $(@).append('<div class="brick__bg_'+posV+'_'+posH+'" data-width="'+width+'" data-height="'+height+'" role="brick-bg"/>')
  # set brick bg-image
  image = $(@).find('.brick__img').attr('src')
  $(@).find(role('brick-bg')).css('background-image', 'url('+image+')')
  # set arrow
  if parseInt(brickData.width) isnt 1
    if brickInfoData and brickInfoData.h is 'right'
      $(@).find(role('brick-info')).addClass 'arrow_left'
    else
      $(@).find(role('brick-info')).addClass 'arrow_right'
  else
    if brickInfoData and brickInfoData.v is 'top'
      $(@).find(role('brick-info')).addClass 'arrow_bottom'
    else
      $(@).find(role('brick-info')).addClass 'arrow_top'

$(role('masonry')).append('<div class="grid-sizer"/>')

@s = undefined

if Modernizr.csstransforms3d
  @modernTranslateY = (y) -> 'translate3d(0px,'+y+'px,0)'
else if Modernizr.csstransforms
  @modernTranslateY = (y) -> 'translateY('+y+'px)'

@clearScrollrData = (el) ->
  data = el.data()
  for key of data
    el.removeAttr('data-'+key)
    delete data[key]  if /^\d+$/.test(key)
  data

@setScrollrData = (data,el) ->
  for key of data
    el.attr('data-'+key,data[key])

scrollrWidth = 1200

isMobile = mobileCheck()
console.log 'mobile ', isMobile

@SetScrollr = ->
  if s
    s.destroy()
  $('body').height('auto')
  $(role('content')).css('margin-top',0)

  windowWidth = $(window).width()
  windowHeight = $(window).height()
  # console.log 'windowWidth', windowWidth
  # console.log 'windowHeight', windowHeight

  pageHeight = $(role('screen')).height() + $(role('content')).outerHeight()

  console.log (not isMobile)
  console.log Math.abs(window.orientation) isnt 90 and windowWidth >= scrollrWidth and pageHeight > windowHeight
  console.log Math.abs(window.orientation) isnt 90 and windowWidth >= scrollrWidth and pageHeight > windowHeight and (not isMobile)

  if Math.abs(window.orientation) isnt 90 and windowWidth >= scrollrWidth and pageHeight > windowHeight and (not isMobile) and $(role('header')).length and $(role('content')).length and $(role('footer')).length and $('body').attr('role') isnt 'no-skrollr'
    footerHeight = $(role('footer')).height()
    # $(role('content')).css('padding-bottom',footerHeight)

    data = clearScrollrData($(role('content')))

    contentPosStart = 0
    contentPosStart = $(role('screen')).height()  if $(role('screen')).length
    contentHeight = $(role('content')).outerHeight()
    # console.log 'contentHeight', contentHeight
    contentPosEnd = contentHeight - windowHeight
    contentScrollHeight = contentPosEnd + contentPosStart

    # data[0] = 'transform: '+modernTranslateY(contentPosStart)
    # data[contentScrollHeight] = 'transform: '+modernTranslateY(-contentPosEnd)
    # setScrollrData(data,$(role('content')))
    $(role('content')).css('margin-top',contentPosStart)

    if $(role('sale')).length
      sale = $(role('sale')).eq(0)
      saleParallaxDistance = 400
      salePosStart = contentPosStart
      saleHeight = sale.height()
      salePosEnd = contentPosStart + saleHeight + saleParallaxDistance
      data = clearScrollrData($(role('sale')))
      data[salePosStart] ='transform: '+modernTranslateY(0)
      data[salePosEnd] = 'transform: '+modernTranslateY(saleParallaxDistance+'px')
      setScrollrData(data,sale)

    data = clearScrollrData($(role('header')))
    data[0] = ''
    data[160] = ''
    setScrollrData(data,$(role('header')))

    data = clearScrollrData($(role('footer')))
    data[contentScrollHeight-footerHeight] = 'position:fixed;top:100%;'
    data[contentScrollHeight-footerHeight+1] = 'position:relative;top:auto;'
    data[contentScrollHeight] = 'position:relative;top:auto;'
    setScrollrData(data,$(role('footer')))

    s = skrollr.init(smoothScrolling:false)
  return

@initializeMasonry = ->
  if $(role('masonry')).length
    @msnry = new Packery(role('masonry'),
      columnWidth: '.grid-sizer'
      itemSelector: '.brick'
      )
  return

@ResizeFunction = ->
  windowWidth = $(window).width()
  windowHeight = $(window).height()

  $('.screen,.screen_first,.login-window').height(windowHeight)
  if windowWidth >= 768
    $('.menu-main__content').height(windowHeight)
    $('.screen_first_floor1,.screen_blog').height(windowHeight)
  else
    $('.menu-main__content').height('auto')
    $('.screen_first_floor1,.screen_blog').height(windowHeight*2)

  pageWidth = $(role('page')).width()
  if $(role('masonry')).length
    # console.log 'pageWidth', pageWidth
    columnCount = Math.ceil(pageWidth/240)
    # console.log 'columnCount', columnCount
    @msnryColumnSize = Math.floor(pageWidth/columnCount)
    $(role('masonry')).find('.grid-sizer').width(msnryColumnSize)
    # @msnry.option(columnWidth: @msnryColumnSize)  if @msnry

    $(role('masonry')).find('.brick').each ->
      # check brick bg-bg data
      brickBGData = $(@).find(role('brick-bg')).data()
      if brickBGData
        brickBGWidth = brickBGHeight = msnryColumnSize
        brickBGWidth *= parseInt(brickBGData.width)
        brickBGHeight *= parseInt(brickBGData.height)
        if brickBGWidth > pageWidth
          brickBGWidth = pageWidth
          brickBGHeight = pageWidth / (brickBGData.width / brickBGData.height)
        $(@).find(role('brick-bg')).width(brickBGWidth).height(brickBGHeight)

      brickData = $(@).data()
      brickWidth = brickHeight = msnryColumnSize
      brickWidth *= parseInt(brickData.width)  if typeof brickData.width isnt 'undefined'
      brickHeight *= parseInt(brickData.height)  if typeof brickData.height isnt 'undefined'
      if brickWidth > pageWidth
        brickWidth = pageWidth
        unless $(@).find(role('brick-info')).length
          brickHeight = pageWidth / (brickData.width / brickData.height)
      $(@).width(brickWidth).height(brickHeight)

    $(role('brick-info')).width(msnryColumnSize).height(msnryColumnSize)

    if windowWidth >= 768
      $('.brick__container.move').css('margin-top',-msnryColumnSize)
      $('.brick-move').css
        '-moz-transform': modernTranslateY(-msnryColumnSize)
        '-ms-transform': modernTranslateY(-msnryColumnSize)
        '-webkit-transform': modernTranslateY(-msnryColumnSize)
        'transform': modernTranslateY(-msnryColumnSize)
    else
      $('.brick__container.move').css('margin-top',-msnryColumnSize)
      $('.brick-move').css
        '-moz-transform': modernTranslateY(0)
        '-ms-transform': modernTranslateY(0)
        '-webkit-transform': modernTranslateY(0)
        'transform': modernTranslateY(0)
  return

$('body').append('<div class="preloader-title" />')
NProgress.start()

window.onload = ->
  $('html').addClass('loaded')
  NProgress.done()
  ResizeFunction()
  initializeMasonry()
  SetScrollr()
  setScrollHintVisibility()

window.onresize = ->
  ResizeFunction()
  SetScrollr()
  setScrollHintVisibility()
window.onorientationchange = ->
  ResizeFunction()
  SetScrollr()
  setScrollHintVisibility()

@UpdatePosition = ->
  if s
    currScroll = s.getScrollTop()
    ResizeFunction()
    SetScrollr()
    s.setScrollTop(currScroll)
  else
    currScroll = $(window).scrollTop()
    ResizeFunction()
    SetScrollr()
    $(window).scrollTop(currScroll)

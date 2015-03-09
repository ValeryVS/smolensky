@SetPlanFunctions = ->
  $(role('svg-convert')).each ->
    $img = $(this)
    imgID = $img.attr("id")
    imgClass = $img.attr("class")
    imgURL = $img.attr("src")
    $.get imgURL, (data) ->
      # Get the SVG tag, ignore the rest
      $svg = $(data).find("svg")
      
      # Add replaced image's ID to the new SVG
      $svg = $svg.attr("id", imgID)  if typeof imgID isnt "undefined"
      
      # Add replaced image's classes to the new SVG
      $svg = $svg.attr("class", imgClass + " replaced-svg")  if typeof imgClass isnt "undefined"
      
      # Remove any invalid XML tags as per http://validator.w3.org
      $svg = $svg.removeAttr("xmlns:a")
      
      # Replace image with new SVG
      $img.replaceWith $svg

      SetPlanFunctions()
      return
    return

  defaultFill = '#786E63'
  hoverFill = '#FF7777'

  $(role('plan-link')).mouseenter ->
    num = $(this).data().num
    $(role('room')).attr('fill',defaultFill)
    $(role('room')+'[data-num="'+num+'"]').attr('fill',hoverFill)

  $(role('plan-link')).mouseleave ->
    $(role('room')).attr('fill',defaultFill)

  $(role('room')).mouseenter ->
    num = $(this).data().num
    $(role('room')).attr('fill',defaultFill)
    $(@).attr('fill',hoverFill)
    $(role('plan-link')).removeClass('hover')
    $(role('plan-link')+'[data-num="'+num+'"]').addClass('hover')

  $(role('room')).mouseleave ->
    $(role('room')).attr('fill',defaultFill)
    $(role('plan-link')).removeClass('hover')

SetPlanFunctions()

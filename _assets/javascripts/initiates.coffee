# mobile check
@mobileCheck = ->
  (/Android|iPhone|iPad|iPod|BlackBerry/i).test(navigator.userAgent || navigator.vendor || window.opera)

# role selector
@role = (s) -> "[role=\"#{s}\"]"

# smooth anchor links
$("a[href*=#]:not([href=#])").click ->
  if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
    target = $(@hash)
    target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
    if target.length
      if typeof s isnt 'undefined'
        s.animateTo(target.offset().top)
      else
        $("html,body").animate
          scrollTop: target.offset().top
        , 1000
        false

$("a[href=#]").click ->
  if typeof s isnt 'undefined'
    s.animateTo(0)
  else
    $("html,body").animate
      scrollTop: 0
    , 1000
    false

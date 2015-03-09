# if $('#contacts_map').length
#   offices = [
#     {
#       latlng: "55.747485,37.581298"
#       zoom: 16
#     }
#     # {
#     #   latlng: "61.24641200000001,73.41417899999999"
#     #   zoom: 16
#     # }
#     # {
#     #   latlng: "55.90070799999999,37.539540999999986"
#     #   zoom: 15
#     # }
#   ]

#   officesData = offices.map((o) ->
#     o.latlng = o.latlng.split(",")
#     o
#   )
#   ymaps.ready ->
#     contactMap = new ymaps.Map("contacts_map",
#       center: officesData[0].latlng
#       zoom: officesData[0].zoom
#     )
#     for i in [0...officesData.length]
#       office = officesData[_i]
#       officePlacemark = new ymaps.GeoObject(geometry:
#         type: "Point"
#         coordinates: office.latlng
#       )
#       contactMap.geoObjects.add officePlacemark
#     # $('[role="offices-tab"]').bind "click", (e) ->
#     #   e.preventDefault()
#     #   $('[role="offices-tab"]').removeClass 'active'
#     #   $(this).addClass 'active'

#     #   officeTab = $(this).data("tab")
#     #   $('[role="office-info"]').removeClass('active')
#     #   $('[role="office-info"][data-tab="'+officeTab+'"]').addClass('active')

#     #   officeOrder = $(this).data("order")
#     #   contactMap.setCenter officesData[officeOrder].latlng
#     #   contactMap.setZoom officesData[officeOrder].zoom

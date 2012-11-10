$ = (id) -> document.getElementById(id)

clusters = []
clusterSprites =
  0: 'cluster beginning'
  1: 'cluster middle'
  2: 'cluster end'
  3: 'cluster optimized'
  4: 'cluster free'
  5: 'cluster unmoved'
  6: 'cluster bad'
  7: 'cluster read'
  8: 'cluster write'

randomize = (previous) ->
  switch previous
    when 0 then parseInt(Math.random() * 9)
    else parseInt(Math.random() * 9)

initClusters = ->
  viewer = $ 'viewer'
  
  clusters[0] = 0
  for i in [1..999]
    clusters[i] = 3

  for cluster in clusters
    viewer.innerHTML += "<div class='#{clusterSprites[cluster]}'></div>"

window.onload = ->
  initClusters()
  viewer = $ 'viewer'

  crank = setInterval ->
    setTimeout ->
      viewer.innerHTML += "<div class='#{clusterSprites[parseInt(Math.random() * 9)]}'></div>"
    , Math.random() * 5000
  , 250

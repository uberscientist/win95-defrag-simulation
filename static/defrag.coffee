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

$ ->
  canvas = document.getElementById 'cluster-canvas'
  ctx = canvas.getContext '2d'

  clusterW = 7
  clusterH = 9
  i = 0

  $(window).resize ->
    sizeCanvas()

  sizeCanvas = ->
    if window.drawer then clearInterval window.drawer
    i = 0

    width = $('#viewer').width()
    height = $('#viewer').height()

    canvas.width = width
    canvas.height = height

    numCluster = Math.round (width/clusterW) * (height/clusterH)
    
    drawCluster()

  drawCluster = () ->
    clusterSprite = new Image()
    clusterSprite.src = 'imgs/cluster_sprites.png'
    clusterSprite.onload = ->
      if window.drawer then clearInterval window.drawer
      srcX = 0
      srcY = 0
      clusterX = -5
      clusterY = 0

      window.drawer = setInterval ->
        width = $('#viewer').width()
        height = $('#viewer').height()
        i++
        if (i * clusterW + 1) > (width - clusterW * 5)
          i = 0
          clusterX = -5
          clusterY += 10

        if clusterY > (height - clusterH)
          console.log 'clusterY, height', clusterY, height
          clearInterval window.drawer
          sizeCanvas()

        ctx.drawImage clusterSprite, srcX+clusterW*parseInt(Math.random() * 9), srcY, clusterW, clusterH, clusterX+=8, clusterY, clusterW, clusterH
      , 1

  sizeCanvas()

randInt = (low, high) -> Math.round Math.random() * (high - 1) + low

genHDD = (numCluster) ->
  # 0=middle 1=beginning 2=end 3=optimized 4=free 5=not moved 6=bad 7=read 8=write
  badRun = 0

  for i in [0..numCluster]
    rnd = randInt(1,600)
    switch rnd
      when 1
        run = randInt(2,10)
        val = 1
      when 2
        run = randInt(2,10)
        val = 2
      when 4 or 40 or 44
        run = randInt(20, 200)
        val = 4
      when 5
        run = randInt(1,100)
        val = 5
      when 6
        run = randInt(5,20)
        val = 6

    if run > 0
      run--
      val
    else
      0

$ ->
  canvas = document.getElementById 'cluster-canvas'
  ctx = canvas.getContext '2d'

  clusterW = 9
  clusterH = 11

  #Resize defrag viewer on window resize
  $(window).resize ->
    resizeCanvas()

  resizeCanvas = ->
    if window.drawer then clearInterval window.drawer

    width = $('#viewer').width()
    height = $('#viewer').height()

    canvas.width = width
    canvas.height = height

    #sizes in clusters
    rowSize = Math.floor(width/clusterW)
    columnSize = Math.floor(height/clusterH)

    numCluster = Math.floor rowSize * columnSize
    hdd = genHDD(numCluster)
    drawHDD(hdd, rowSize, columnSize, width, height)


  drawHDD = (hdd, rowSize, columnSize, width, height) ->
    clusterSprite = new Image()
    clusterSprite.src = 'imgs/cluster_sprites.png'
    clusterSprite.onload = ->

      drawCluster = (cluster, index) ->
        xOffset = (index % rowSize) * clusterW
        yOffset = Math.floor(index / rowSize) * clusterH
        ctx.drawImage clusterSprite, srcX+clusterW*cluster, srcY, clusterW, clusterH, xOffset, yOffset, clusterW, clusterH

      srcX = 0
      srcY = 0
      clusterX = -5
      clusterY = 0

      for cluster, i in hdd
        drawCluster(cluster, i)

      ###
      intervalCluster = ->
        if window.drawer then clearInterval window.drawer

        window.drawer = setInterval ->
          width = $('#viewer').width()
          height = $('#viewer').height()
          i++
          if i * (clusterW + 1) > (width - clusterW*2)
            ctx.drawImage clusterSprite, srcX+clusterW*4, srcY, clusterW, clusterH, clusterX+8, clusterY, clusterW, clusterH
            i = 0
            clusterX = -5
            clusterY += 10

          if clusterY > (height/2)
            resizeCanvas()
            clearInterval window.drawer

          ctx.drawImage clusterSprite, srcX+clusterW*3, srcY, clusterW, clusterH, clusterX+=8, clusterY, clusterW, clusterH
          ctx.drawImage clusterSprite, srcX+clusterW*8, srcY, clusterW, clusterH, clusterX+8, clusterY, clusterW, clusterH
        , 100
        ###

  resizeCanvas()

randInt = (low, high) -> Math.round Math.random() * (high - 1) + low

genHDD = (numCluster) ->
  # 0=beginning 1=middle 2=end 3=optimized 4=free 5=not moved 6=bad 7=read 8=write
  # Generates HDD data
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

  # Resize defrag viewer on window resize
  $(window).resize ->
    resizeCanvas()

  resizeCanvas = ->
    if window.drawer then clearInterval window.drawer

    width = $('#viewer').width()
    height = $('#viewer').height()

    canvas.width = width
    canvas.height = height

    # Canvas size in clusters
    rowSize = Math.floor(width/clusterW)
    columnSize = Math.floor(height/clusterH)

    numCluster = Math.floor rowSize * columnSize

    # Generate and draw new HD data
    hdd = genHDD(numCluster)
    drawHDD(hdd, rowSize, columnSize, width, height)


  drawHDD = (hdd, rowSize, columnSize, width, height) ->
    clusterSprite = new Image()
    clusterSprite.src = 'imgs/cluster_sprites.png'
    clusterSprite.onload = ->

      # Function takes cluster type and index, then draws to canvas
      drawCluster = (cluster, index) ->
        xOffset = (index % rowSize) * clusterW
        yOffset = Math.floor(index / rowSize) * clusterH
        ctx.drawImage clusterSprite, clusterW*cluster, 0, clusterW, clusterH, xOffset, yOffset, clusterW, clusterH

      # Draw the HDD data
      for cluster, i in hdd
        drawCluster(cluster, i)


      # Drawing Functions
      readCluster = ->

      writeCluster = (cluster, index) ->
        drawCluster(8, index)
        setTimeout ->
          drawCluster(3, index)
        , 100

      animate = (hdd) ->
        if window.drawer then clearInterval window.drawer
        index = 0

        window.drawer = setInterval ->
          setTimeout ->
            switch hdd[index]
              when 0
                writeCluster(3, index)
            index++
          , randInt(500, 5000)
        , 200

      animate(hdd)

  resizeCanvas()

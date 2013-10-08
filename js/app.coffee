$ ->

  # Initialize canvas
  width = $(document).width() - $("#instructions").outerWidth()
  height = $(document).height()

  g = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)

  # Initialize data
  nodes = [
    { name: "Angela Li" }
    { name: "Angela Lee" }
    { name: "Vivian Leung" }
  ]

  links = [
    { source: 0, target: 1 }
    { source: 0, target: 2 }
    { source: 1, target: 0 }
  ]

  # Initialize force layout
  tick = ->
    link.attr("x1", (d) -> d.source.x)
        .attr("y1", (d) -> d.source.y)
        .attr("x2", (d) -> d.target.x)
        .attr("y2", (d) -> d.target.y)

    node.attr("cx", (d) -> d.x)
        .attr("cy", (d) -> d.y)

  force = d3.layout.force()
    .linkDistance(100)
    .charge(-500)
    .nodes(nodes)
    .links(links)
    .size([width, height])
    .on("tick", tick)
    .start()

  # Render nodes and links
  renderNodes = -> g.selectAll(".node")
    .data(nodes)
    .enter()
  .append("circle")
    .attr("r", 20)
    .style("fill", "#AAA")

  renderLinks = -> g.selectAll(".link")
    .data(links)
    .enter()
  .append("line")

  link = renderLinks()

  node = renderNodes()
  node.append("title")
    .text((d) -> d.name)

  # Keep track of selected node / link
  selectedNode = null
  selectedLink = null

  # Creates node
  createNode = ->
    console.log "TODO: make new node"

  # Selects or deselects node
  toggleNodeSelect = ->
    console.log "TODO: select / deselect node"

  # Selects or deselects link
  toggleLinkSelect = ->
    console.log "TODO: select link"

  # Deletes node or link
  deleteNodeOrLink = ->
    return unless selectedNode or selectedLink
    console.log "TODO: delete node or link"

  # Renames node
  renameNode = ->
    return unless selectedNode

    name = prompt("Please enter a new name:")
    console.log "TODO: rename node #{name}"

  # Colors node
  colorNode = ->
    return unless selectedNode

    color = prompt("Please enter a new hex color:")
    pattern = /^#[0-9A-F]{6}$/i

    if pattern.test(color)
      console.log "TODO: color node #{color}"

  # Initialize interaction
  d3.select("html").on("keypress", ->
    switch (d3.event.keyCode)
      when 100 then deleteNodeOrLink() # 'D'
      when 110 then renameNode() # 'N'
      when 99 then colorNode() # 'C'
  )

  g.on("click", ->
    switch (d3.event.toElement.tagName)
      when "svg" then createNode()
      when "circle" then toggleNodeSelect()
      when "line" then toggleLinkSelect()
  )
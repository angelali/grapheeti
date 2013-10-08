$ ->

  # Initialize canvas
  width = 960
  height = 500

  g = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)

  # Initialize force layout
  nodes = []
  links = []

  tick = ->
    g.selectAll("circle")
      .attr("transform", (d) -> "translate(#{d.x}, #{d.y})")

  force = d3.layout.force()
    .nodes(nodes)
    .links(links)
    .size([width, height])
    .on("tick", tick)

  # Adds node to graph
  addNode = ->
    node = {
      id: nodes.length + 1
    }
    nodes.push(node)

    g.selectAll("circle")
      .data(nodes)
      .enter()
      .append("circle")
      .attr("r", 10)
      .call(force.drag)

    force.start()

  # Set handlers on controls
  $("#add-node").click(addNode)
  $("#rename-node").click(renameNode)
  $("#delete-node").click(deleteNode)

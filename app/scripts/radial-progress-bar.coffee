( ( $ ) ->
  'use strict'

  circleColor = '#E9DF4A'
  textColor = '#303334'

  # data
  data = [0.5, 0.25, 0.37, 0.68]

  # options
  radius = 136
  border = 13
  padding = 0
  startPercent = 0

  # @todo: reconsider
  endPercent = 0.85

  twoPi = Math.PI * 2
  formatPercent = d3.format '.0%'
  boxSize = ( radius + padding ) * 2

  # count and step
  count = Math.abs (endPercent - startPercent ) / 0.01
  step = if endPercent < startPercent then -0.01 else 0.01

  arc = d3.svg.arc()
    .startAngle 0
    .innerRadius radius
    .outerRadius radius - border

  # select all blocks
  circles = d3
    .selectAll '.quality-item'
    .select 'article'
    .select '.quality-item__circle'

  # draw boxes
  svg = circles.insert('svg', ':first-child')
    .attr 'class', 'svg-content'
    .attr 'width', '100%'
    .attr 'height', '100%'

  # g
  g = svg.append 'g'
    .attr 'transform', 'translate(' + boxSize / 2 + ',' + boxSize / 2 + ')'

  # meter
  meter = g.append 'g'
    .attr 'class', 'progress-meter'

  # background line
  meter.append 'path'
    .attr 'class', 'background'
    .attr 'fill', '#ccc'
    .attr 'fill-opacity', 0.1
    .attr 'd', arc.endAngle twoPi

  # front line (real progress)
  foreground = meter.append 'path'
    .attr 'class', 'foreground'
    .attr 'fill', circleColor
    .attr 'fill-opacity', 1

  # text inside
  numberText = meter.append 'text'
    .attr 'fill', textColor
    .attr 'text-anchor', 'middle'
    .attr 'dy', '.35em'

  updateProgress = ( progress ) ->
    foreground.attr 'd', arc.endAngle twoPi * progress
    numberText.text formatPercent progress

  progress = startPercent

  loops = ->
    updateProgress progress

    if count > 0
      count--
      progress += step
      setTimeout loops, 15

  loops()

) jQuery

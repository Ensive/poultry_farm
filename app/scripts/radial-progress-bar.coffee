( ( $ ) ->
  'use strict'

  color = '#E9DF4A'

  radius = 136
  border = 13
  padding = 4
  startPercent = 0
  endPercent = 0.85

  twoPi = Math.PI * 2
  formatPercent = d3.format '.0%'
  boxSize = ( radius + padding ) * 2

  count = Math.abs (endPercent - startPercent ) / 0.01
  step = if endPercent < startPercent then -0.01 else 0.01

  arc = d3.svg.arc()
    .startAngle 0
    .innerRadius radius
    .outerRadius radius - border

  parent = d3.select '.quality'

  # circles = parent.selectAll '.quality-item'
    # .attr

  svg = parent.append('svg')
    .attr 'width', boxSize
    .attr 'height', boxSize

  # defs
  defs = svg.append 'defs'

  # filter
  filter = defs.append 'filter'
    .attr 'id', 'blur'

  filter.append 'feGaussianBlur'
    .attr 'in', 'SourceGraphic'
    .attr 'stdDeviation', '7'

  # g
  g = svg.append 'g'
    .attr 'transform', 'translate(' + boxSize / 2 + ',' + boxSize / 2 + ')'

  # meter
  meter = g.append 'g'
    .attr 'class', 'progress-meter'

  meter.append 'path'
    .attr 'class', 'background'
    .attr 'fill', '#ccc'
    .attr 'fill-opacity', 0.1
    .attr 'd', arc.endAngle twoPi

  foreground = meter.append 'path'
    .attr 'class', 'foreground'
    .attr 'fill', color
    .attr 'fill-opacity', 1
    # .attr 'stroke', color
    # .attr 'stroke-width', 0
    # .attr 'stroke-opacity', 1

  front = meter.append 'path'
    .attr 'class', 'foreground'
    .attr 'fill', color
    .attr 'fill-opacity', 1

  numberText = meter.append 'text'
    .attr 'fill', '#fff'
    .attr 'text-anchor', 'middle'
    .attr 'dy', '.35em'

  updateProgress = ( progress ) ->
    foreground.attr 'd', arc.endAngle twoPi * progress
    front.attr 'd', arc.endAngle twoPi * progress
    numberText.text formatPercent progress

  progress = startPercent

  loops = ->
    updateProgress progress

    if count > 0
      count--
      progress += step
      setTimeout loops, 10

  loops()

) jQuery

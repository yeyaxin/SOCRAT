'use strict'

BaseService = require 'scripts/BaseClasses/BaseService.coffee'

module.exports = class ChartsVegaScatterplot extends BaseService

  @inject '$q',
    '$stateParams',
    'app_analysis_charts_dataTransform',
    'app_analysis_charts_list',
    'app_analysis_charts_sendData',
    'app_analysis_charts_checkTime',
    'app_analysis_charts_dataService',
    'app_analysis_charts_msgService',
    'app_analysis_charts_scatterPlot'

  initialize: ->
    @msgService = @app_analysis_charts_msgService
    @dataService = @app_analysis_charts_dataService
    @dataTransform = @app_analysis_charts_dataTransform
    @list = @app_analysis_charts_list
    @sendData = @app_analysis_charts_sendData
    @checkTime = @app_analysis_charts_checkTime
    @DATA_TYPES = @dataService.getDataTypes()
    @scatterPlot = @app_analysis_charts_scatterPlot

    @ve = require 'vega-embed'

  drawVegaScatterplot: (width,height,data,_graph,labels,ranges) ->

#    toFindMaxMin = []
#    for d in data
#      toFindMaxMin.push(d.x)
#    maxValue = Math.max(toFindMaxMin)
#    minValue = Math.min(toFindMaxMin)
#    intervalLength = (maxValue - minValue) / @INTERVEL_COUNT
#
#    intervalFlags = [0]
#    categorizedDataPoints = []
#    for counter in [1...@INTERVEL_COUNT]
#      intervalFlags.push(intervalFlags[..].pop() + intervalLength)
#      categorizedDataPoints.push([])
#    intervalFlags.shift()
#
#    for d in data
#      for interval in intervalFlags
#        if d.x <= interval
#          categorizedDataPoints[intervalFlags.findIndex(interval)].push(d.x)
#          break
#
#    resultDataPoints = []
#    for dataPoints in categorizedDataPoints
#      resultDataPoints.push({"intervel": })

    console.log(data[0]);
    console.log(data[1]);
    console.log(data[2]);
    console.log(data[3]);
    console.log(data[4]);
    console.log(data[5]);

    resultData = []
    for d, dIndex in data
      singleData = {"index": dIndex, "value": d.x}
      resultData.push(singleData)

    vlSpec =
      {
        "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
        "width": 1000,
        "height": 400,
        "data": {"values": resultData},
        "mark": "circle",
        "encoding": {
          "x": {"field": "index", "type": "quantitative"},
          "y": {"field": "value", "type": "quantitative"}
        }
      }
    opt = {"actions": {export: true, source: false, editor: false}}

    @ve '#vis', vlSpec, opt, (error, result) ->
# Callback receiving the View instance and parsed Vega spec
# result.view is the View, which resides under the '#vis' element
      return

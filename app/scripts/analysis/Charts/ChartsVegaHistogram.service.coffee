'use strict'

BaseService = require 'scripts/BaseClasses/BaseService.coffee'

module.exports = class ChartsVegaHistogram extends BaseService

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

    @INTERVEL_COUNT = 5

  drawVegaHistogram: (width,height,data,_graph,labels,ranges) ->

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
        "mark": "bar",
        "encoding": {
          "x": {
            "bin": true,
            "field": "value",
            "type": "quantitative"
          },
          "y": {
            "aggregate": "count",
            "type": "quantitative"
          }
        }
      }
    opt = {"actions": {export: true, source: false, editor: false}}

    @ve '#vis', vlSpec, opt, (error, result) ->
# Callback receiving the View instance and parsed Vega spec
# result.view is the View, which resides under the '#vis' element
      return

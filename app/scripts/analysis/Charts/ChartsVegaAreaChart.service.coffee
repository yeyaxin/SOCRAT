'use strict'

BaseService = require 'scripts/BaseClasses/BaseService.coffee'

module.exports = class ChartsVegaAreaChart extends BaseService

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

  drawVegaAreaChart: (width,height,data,_graph,labels,ranges) ->

    resultData = []
    for d, dIndex in data
      singleData = {"index": dIndex, "value": d.x}
      resultData.push(singleData)

    vlSpec =
      {
        "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
        "width": 1000,
        "height": 500,
        "data": {"values": resultData},
        "mark": "area",
        "encoding": {
          "x": {
            "field": "index", "type": "temporal",
          },
          "y": {
            "field": "value", "type": "quantitative",
            "axis": {"title": labels.xLab.value}
          }
        }
      }

    opt = {"actions": {export: true, source: false, editor: false}}

    @ve '#vis', vlSpec, opt, (error, result) ->
# Callback receiving the View instance and parsed Vega spec
# result.view is the View, which resides under the '#vis' element
      return

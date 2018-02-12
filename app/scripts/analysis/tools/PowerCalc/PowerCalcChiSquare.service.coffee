'use strict'

BaseService = require 'scripts/BaseClasses/BaseService.coffee'

###
  @name: app_analysis_powercalc_chiSquare
  @type: service
  @desc: Performs chiSquare test analysis
###


module.exports = class PowerCalcTwoTGUI extends BaseService
  @inject 'app_analysis_powerCalc_msgService',
    '$timeout'

  initialize: ->

    # dependecies
    @msgService = @app_analysis_powerCalc_msgService
    @name = 'Generic chi-square test'
    @powerCalc = require 'powercalc'

    #variables needed for chisquare
    @chiSquareChi2 = 10
    @chiSquareChi2Max = 20
    @chiSqrPower=0.5
    @chiSquareProN = 100
    @chiSquareProNMax = 150
    @chiSquareN=100
    @chiSquareNMax=75
    @chiSquareDf=10
    @chiSquareDfMax = 20
    @chiSquareAlpha=0.05
    @update()


  setAlpha: (alphaIn) ->
    @chiSquareAlpha = alphaIn
    @update()
    return

  getName: () ->
    return @name

  getParams: () ->
    @parameters = 
      power: @chiSqrPower
      chi2: @chiSquareChi2
      chi2Max: @chiSquareChi2Max
      proN: @chiSquareProN
      proNMax: @chiSquareProNMax
      n: @chiSquareN
      nMax: @chiSquareNMax
      df: @chiSquareDf
      dfMax: @chiSquareDfMax


  setParams: (newParams) ->
    @chiSquareChi2 = newParams.chi2
    @chiSquareProN = newParams.proN
    @chiSquareN = newParams.n
    @chiSquareDf = newParams.df
    @checkRange()
    @update()
    return

  checkRange: () ->
    @chiSquareChi2Max = Math.max(@chiSquareChi2Max, @chiSquareChi2)
    @chiSquareProNMax = Math.max(@chiSquareProN, @chiSquareProNMax)
    @chiSquareNMax = Math.max(@chiSquareNMax, @chiSquareN)
    @chiSquareDfMax = Math.max(@chiSquareDf, @chiSquareDfMax)
    return


  update: ()->
    input = 
      chi2: @chiSquareChi2
      proN: @chiSquareProN
      n: @chiSquareN
      df: @chiSquareDf
      alpha: @chiSquareAlpha
    params = @powerCalc.SimpleChi2GUI_handle(input)
    @chiSqrPower = params.Power
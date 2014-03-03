define ['app', 'marionette', 'views/header/header'], (App, Marionette, HeaderView) ->

  class Controller extends Marionette.Controller

    initialize: (options) ->
      { @collection } = options
      
      @headerView = @getHeaderView @collection
      App.headerRegion.show @headerView

      @headerView.on 'check:clicked', ->
        App.vent.trigger 'checkout:show'

      App.vent.on 'checkout:show', =>
        @hideHeader()

      App.vent.on 'order:created', =>
        @showHeader()

    hideHeader: ->
      $('#app-container').addClass 'checkout-state'
      App.headerRegion.close()
      delete @headerView

    showHeader: ->
      $('#app-container').removeClass 'checkout-state'
      @headerView = @getHeaderView @collection
      App.headerRegion.show @headerView

    getHeaderView: (collection) ->
      new HeaderView
        collection: collection
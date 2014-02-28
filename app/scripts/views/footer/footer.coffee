define ['app', 'marionette', 'templates/footer/footer', 'templates/footer/_checkout', 'templates/footer/_delivery'], 
(App, Marionette, template, checkoutButtonTemplate, deliveryButtonTemplate) ->

  class Footer extends Marionette.ItemView
    template: template

    events:
      'click a.checkout': 'showCheck'
      'click a.delivery': 'addOrder'

    collectionEvents:
      'add':    'showCheckoutButton'
      'remove': 'hideButton'

    showCheckoutButton: ->
      @$('#workspace').html checkoutButtonTemplate

    showDeliveryButton: ->
      @$('#workspace').html deliveryButtonTemplate

    hideButton: ->
      @$('#workspace').html @workspaceDOM

    showCheck: (e) ->
      e.preventDefault()
      @showDeliveryButton()
      @trigger 'checkout:clicked'

    addOrder: (e) ->
      e.preventDefault()
      console.log 'Обработка заказа'

    onRender: ->
      @workspaceDOM = @$('#workspace').children().clone()
      if @collection.length > 0
        @showCheckoutButton()
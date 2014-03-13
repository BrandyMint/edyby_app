define ['templates/modal_windows/quantity_selector', 'helpers/application_helpers'],
(template, Helpers) ->

    class QuantitySelector extends Marionette.ItemView
      template: template
      templateHelpers: -> Helpers

      ui:
        plusButton:    '#kormapp-plus-sign'
        minusButton:   '#kormapp-minus-sign'
        confirmButton: '.kormapp-modal-button'
        quantity:      '.kormapp-quantity'
        result:        '.kormapp-result'
        outside:       '.kormapp-dark-background'

      events:
        'click @ui.minusButton':   'decreaseQuantity'
        'click @ui.plusButton':    'increaseQuantity'
        'click @ui.confirmButton': 'confirmChanges'
        'click @ui.outside': 'close'

      serializeData: ->
        _.extend @model.toJSON(),
          product: @model.product

      decreaseQuantity: (e) ->
        e.preventDefault()
        unless @model.get('quantity') < 1
          @model.set 'quantity', @model.get('quantity')-1
          @_updateView()

      increaseQuantity: (e) ->
        e.preventDefault()
        @model.set 'quantity', @model.get('quantity')+1
        @_updateView()

      confirmChanges: (e) ->
        e.preventDefault()
        @close()

      onClose: ->
        @model.destroy() if @model.get('quantity')==0

      _updateView: ->
        $(@ui.quantity).html @model.get('quantity')
        $(@ui.result).html Helpers.money @model.get('total_cost')

define ->

  class ProductsUpdaterController extends Marionette.Controller

    initialize: ({ @url, @cart, @vendor, @categories, @products }) ->
      @VENDOR_KEY = @vendor.get 'key'

      # @listenTo @products, 'reset', ->
      #   console.log 'Коллекция продуктов обновлена', @products

      # @listenTo @categories, 'reset', ->
      #   console.log 'Коллекция категорий обновлена', @categories

      $.ajax
        url: @url
        headers:
          'X-Vendor-Key': @VENDOR_KEY
        success: (data) =>
          console.log 'От сервера получены данные для обновления', data
          @_updateEntities data
        error: ->
          console.log 'Ошибка получения списка продуктов с сервера'

    _updateEntities: (data) ->
      @products.reset   data.products
      @categories.reset data.categories
      @vendor.set       data.vendor
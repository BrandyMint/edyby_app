define ['marionette', 'data/products'], (Marionette, productsData) ->
  
  window.App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    mainRegion:   "#main-region"
    footerRegion: "#footer-region"
    checkRegion:  "#check-region"
    modalRegion:  "#modal-region"

  App.addInitializer ->
    require ['models/profile'], (ProfileModel) =>
      App.profile = new ProfileModel
      App.profile.fetch()

    require ['controllers/cart', 'collections/cart'], (CartController, CartCollection) ->
      cartCollection = new CartCollection
      cartCollection.fetch()
      new CartController collection: cartCollection

    require ['controllers/quantity_selector'], (QuantitySelectorController) ->
      new QuantitySelectorController

    require ['controllers/check'], (CheckController) ->
      new CheckController 
        profile: App.profile
        cart:    App.cart

    require ['collections/products', 'views/products/list'], (ProductsCollection, ProductsView) =>
      productsListCollection = new ProductsCollection productsData
      productsListView = new ProductsView collection: productsListCollection
      App.mainRegion.show productsListView

    require ['controllers/header'], (HeaderController) ->
      new HeaderController collection: App.cart

    require ['views/footer/footer'], (FooterView) ->
      footerView = new FooterView
        collection: App.cart
        profile:    App.profile
      App.footerRegion.show footerView

      footerView.on 'checkout:clicked', ->
        App.vent.trigger 'checkout:show'

      footerView.on 'delivery:clicked', ->
        App.vent.trigger 'order:create:prepare'

    require ['controllers/orders'], (OrderController) ->
      new OrderController
        profile: App.profile
        cart:    App.cart

  App.on 'start', ->
    console.log 'App starting....'

  App.on 'initialize:after', ->
    Backbone.history.start()

  App
define ['views/footer/footer'], (FooterView) ->

  class FooterController extends Marionette.Controller

    initialize: (options) ->
      { @cart, @app, @user, @vendor, @vent } = options

      @footerView = new FooterView
        app:     @app
        cart:    @cart
        user:    @user
        vent:    @vent
        vendor:  @vendor

      @app.mainLayout.footerRegion.show @footerView

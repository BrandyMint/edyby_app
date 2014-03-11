define ['templates/main_layout', 'helpers/application_helpers'],
(template, Helpers) ->
    class MainLayout extends Marionette.Layout

      el: '#kormapp-container'
      #className: 'content'
      template: template

      regions:
        headerRegion: "#kormapp-header-region"
        mainRegion:   "#kormapp-main-region"
        footerRegion: "#kormapp-footer-region"
        checkRegion:  "#kormapp-check-region"
        modalRegion:  "#kormapp-modal-region"
        checkRegion: '#check'

      initialize: (options) ->
        { @app, @cart } = options
define ['templates/narrow_layout', 'helpers/application_helpers'],
(template, Helpers) ->
    class NarrowLayout extends Marionette.Layout
      el: '@kormapp-container'
      template: template

      regions:
        headerRegion: "@kormapp-header-region"
        products:     "@kormapp-products-region"
        categories:   "@kormapp-categories-region"
        footerRegion: "@kormapp-footer-region"
        checkRegion:  "@kormapp-check-region"
        modalRegion:  "@kormapp-modal-region"

      onRender: ->
        @modalRegion.on 'close', (e) ->
          $('body').scrollTop(0)



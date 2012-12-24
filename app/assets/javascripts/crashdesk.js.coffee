window.Crashdesk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Decorators: {}
  init: ->
    new Crashdesk.Routers.Apps()
    Backbone.history.start()

$(document).ready ->
  Crashdesk.init()

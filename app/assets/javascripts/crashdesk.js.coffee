window.Crashdesk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Crashdesk.Routers.Apps()
    Backbone.history.start()

$(document).ready ->
  Crashdesk.init()

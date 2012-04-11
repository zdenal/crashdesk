class Crashdesk.Routers.Apps extends Backbone.Router
  routes:
    '': 'index'
    'apps/:id': 'show'

  initialize: ->
    @collection = new Crashdesk.Collections.Apps()
    @collection.fetch()

  index: ->
    view = new Crashdesk.Views.AppsIndex(collection: @collection)
    $('#content').html( view.render().el )

  show: (id) ->
    alert "App #{id}"

  nothing: ->

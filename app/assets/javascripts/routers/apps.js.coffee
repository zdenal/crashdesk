class Crashdesk.Routers.Apps extends Backbone.Router
  routes:
    '': 'index'
    ':id/errors': 'show'

  initialize: ->

  index: ->
    collection = new Crashdesk.Collections.Apps()
    collection.fetch()
    view = new Crashdesk.Views.AppsIndex(collection: collection)
    $('#content').html( view.render().el )

  show: (id) ->
    apps = new Crashdesk.Collections.Apps()
    apps.fetch
      success:() ->
        app = apps.get id
        view = new Crashdesk.Views.AppsShow
          model: app
          apps: apps
        $('#content').html( view.render().el )

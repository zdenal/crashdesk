class Crashdesk.Routers.Apps extends Backbone.Router
  routes:
    '': 'index'
    ':id/errors': 'show'

  initialize: ->

  index: ->
    collection = new Crashdesk.Collections.Apps()
    collection.fetch
      success: () =>
        if collection.isEmpty()
          view = new Crashdesk.Views.AppsIndex()
          $('#content').html( view.render().el )
        else
          this.navigate "#{collection.first().id}/errors", true

  show: (id) ->
    apps = new Crashdesk.Collections.Apps()
    apps.fetch
      success:() ->
        app = apps.get id
        view = new Crashdesk.Views.AppsShow
          model: app
          apps: apps
        $('#content').html( view.render().el )

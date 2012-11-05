class Crashdesk.Routers.Apps extends Backbone.Router
  routes:
    '': 'index'
    ':id/errors': 'show'

  initialize: ->

  index: ->
    collection = new Crashdesk.Collections.Apps()
    collection.fetch
      success: () =>
        #this.navigate "#{collection.first().id}/errors", true
        view = new Crashdesk.Views.AppsIndex(collection: collection)
        $('#content').html( view.render().el )

  show: (id) ->
    apps = new Crashdesk.Collections.Apps()
    apps.fetch
      success:() ->
        app = apps.get id
        console.log apps
        view = new Crashdesk.Views.AppsShow
          model: app
          apps: apps
        $('#content').html( view.render().el )

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
    app = new Crashdesk.Models.App _id: id
    app.fetch
      success: ->
        view = new Crashdesk.Views.AppsShow(model: app)
        $('#content').html( view.render().el )

class Crashdesk.Collections.Apps extends Backbone.Collection

  url   : '/api/apps'
  model : Crashdesk.Models.App

  get_form: (app) ->
    new Crashdesk.Views.AppsForm
      model: app
      collection: @

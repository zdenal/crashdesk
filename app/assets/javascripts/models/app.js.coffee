class Crashdesk.Models.App extends Backbone.Model
  urlRoot: 'api/apps'
  idAttribute: "_id"

  get_code: ->
    new Crashdesk.Views.AppsCode
      model: @

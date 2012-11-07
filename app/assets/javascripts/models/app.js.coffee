class Crashdesk.Models.App extends Backbone.Model
  urlRoot: 'api/apps'

  get_code: ->
    new Crashdesk.Views.AppsCode
      model: @

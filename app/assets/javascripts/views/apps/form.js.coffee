class Crashdesk.Views.AppsForm extends Backbone.View

  template: JST['apps/form']


  initialize: ->
    @app = new Crashdesk.Models.App()

  render: ->
    $(@el).html(@template(app: @app))
    this

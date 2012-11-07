class Crashdesk.Views.AppsCode extends Backbone.View
  id: 'app_code'

  template: JST['apps/code']

  initialize: ->
    $('#app_code').remove()

  render: ->
    $(@el).html(@template(app: @model))
    this

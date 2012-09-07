class Crashdesk.Views.AppsCode extends Backbone.View
  className: 'modal hide fade'
  id: 'app_code'

  template: JST['apps/code']

  initialize: ->
    $('#app_code').remove()

  render: ->
    $(@el).html(@template(app: @model))
    $(@el).modal()
    this

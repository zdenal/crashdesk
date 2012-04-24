class Crashdesk.Views.AppsShow extends Backbone.View
  id: 'app'

  template: JST['apps/show']

  render: ->
    $(@el).html(@template())
    this

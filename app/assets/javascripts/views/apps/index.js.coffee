class Crashdesk.Views.AppsIndex extends Backbone.View

  template: JST['apps/index']

  initialilze: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(apps: @collection))
    this

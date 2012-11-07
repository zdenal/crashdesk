class Crashdesk.Views.AppsIndex extends Backbone.View
  id        : 'apps'
  className : 'row-fluid'

  template: JST['apps/index']

  events:
    'submit form': 'newApp'

  serialize: ->
    name        : this.$('#app_name').val()

  initialize: ->
    @app = new Crashdesk.Models.App()
    @app.on('change:errors', @render, this)

  render: ->
    $(@el).html(@template(app: @app))
    this

  newApp: (event) ->
    event.preventDefault()
    @app.save @serialize(),
      wait: true
      success: =>
        Backbone.history.navigate("#{@app.id}/errors", true)
      error: (model, response) =>
        @app.set("errors", $.parseJSON(response.responseText).errors)

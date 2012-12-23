class Crashdesk.Collections.Collaborators extends Backbone.Collection

  url: ->
    "/api/collaborators?app_id=#{@app.id}"

  set_app: (app) ->
    @app = app
    @

  get_form: (collaborator) ->
    unless @app?
      throw 'Please define app for collaborators by "set_app"'
    new Crashdesk.Views.CollaboratorsForm
      model      : collaborator
      app        : @app
      collection : @

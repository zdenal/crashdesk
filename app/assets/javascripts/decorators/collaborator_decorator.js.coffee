class Crashdesk.Decorators.Collaborator

  constructor: (collaborator) ->
    @collaborator = collaborator

  list_name: ->
    if @collaborator.get('is_tmp')
      "not registered (#{@collaborator.get('email')})"
    else
      "#{@collaborator.get('name')} (#{@collaborator.get('email')})"

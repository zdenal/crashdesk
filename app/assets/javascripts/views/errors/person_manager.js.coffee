#= require ../shared/tag_manager

class Crashdesk.Views.ErrorPersonManager extends Crashdesk.Views.SharedTagManager
  id: 'person-manager'

  render: ->
    $(@el).html @template
      title: 'Responsible persons'
      tags: @model.get('person')
    $(@el).modal().on 'shown', =>
      this.$('#tags').tagsInput()
    .on 'hide', @updateErrorPersons
    this

  updateErrorPersons: =>
    @model.set 'person', @serialize().tags.split(',')

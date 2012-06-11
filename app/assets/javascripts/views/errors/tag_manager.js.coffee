#= require ../shared/tag_manager

class Crashdesk.Views.ErrorTagManager extends Crashdesk.Views.SharedTagManager
  id: 'tag-manager'

  render: ->
    $(@el).html @template
      title: 'Tags'
      tags: @model.get('tags')
    $(@el).modal().on 'shown', =>
      this.$('#tags').tagsInput()
    .on 'hide', @updateErrorTags
    this

  updateErrorTags: =>
    @model.save tags: @serialize().tags.split(','),
      wait: true

class Crashdesk.Models.Error extends Backbone.Model

  customers: ->
    if @get('error_info')? and false
      _customers = info.extra.customer for info in @get('error_info')
    else
      []

  get_tag_manager: ->
    new Crashdesk.Views.ErrorTagManager
      model: @

  get_person_manager: ->
    new Crashdesk.Views.ErrorPersonManager
      model: @

  is_selected: ->
    @get('selected')

  select: ->
    @set 'selected', true

  deselect: ->
    @set 'selected', false

  css_warning_level: ->
    _no = @get('no')
    if _no < 10
      return 'info'
    else if _no < 30
      return 'warning'
    else if _no < 70
      return 'important'
    else
      return 'inverse'

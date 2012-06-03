class Crashdesk.Collections.Errors extends Backbone.Collection

  url   : '/api/errors'
  model : Crashdesk.Models.Error

  select: (error) ->
    @selected().deselect() if @selected()?
    error.select()

  selected: ->
    @find (error) ->
      error.is_selected()

  selectedIndex: ->
    @indexOf(@selected())

  hasNext: ->
    @selectedIndex() + 1 < @length

  hasPrev: ->
    @selectedIndex() > 0

  next: ->
    @at(@selectedIndex() + 1)

  prev: ->
    @at(@selectedIndex() - 1)

  selectNext: ->
    if @hasNext()
      @select(@next())

  selectPrev: ->
    @select(@prev()) if @hasPrev()

  destroySelected: ->
    # has to call 'destroy' before set new selected item in collection
    if @hasNext()
      next = @next()
    else
      next = @prev()
    @selected().destroy()
    @select(next) if next?


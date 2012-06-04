class Crashdesk.Views.ShortError extends Backbone.View
  className : 'error-preview clickable'
  tagName   : 'article'

  template: JST['errors/short_error']

  events:
      'click': 'showEvent'

  initialize: ->
    @model.on 'change', @render, this
    @model.on 'destroy', @remove, this
    @model.on 'change:selected', @changeSelected, this

  render: ->
    $(@el).html(@template(error: @model))
    @connectByFirehose()
    this

  showEvent: (e) ->
    e.preventDefault()
    @collection.select(@model)

  showErrorDetail: ->
    error_detail = new Crashdesk.Views.ErrorDetail
      model: @model,
      collection: @collection
    $('#error').html(error_detail.render().el)
    @showCustomers()

  showCustomers: ->
    list = new Crashdesk.Views.CustomerList(model: @model)
    $("##{list.id}").remove()
    $('#error').after(list.render().el)

  changeSelected: ->
    if @model.is_selected()
      $(@el).addClass 'selected'
      @showErrorDetail()
      @setPositionInList()
    else
      $(@el).removeClass 'selected'

  setPositionInList: ->
    scrollPosition = this.$el.position().top
    window_height = this.$el.parents('#endless_list').height()
    move_to = ( scrollPosition - this.$el.parent().position().top )
    if scrollPosition > ( window_height - 100) or scrollPosition < 100
      this.$el.parents('#endless_list').scrollTop move_to

  connectByFirehose: ->
    new Firehose.Consumer(
      uri: "//localhost:7474/errors/#{@model.get('id')}.json"
      error: =>
        console.log "#{@model.get('id')} has got error"
      disconnected: =>
        console.log "#{@model.get('id')} disconnected via firehose"
      connected: =>
        console.log "#{@model.get('id')} connected via firehose"
      message: (data) =>
        console.log data
        console.log "#{@model.get('id')} got message"
        @model.set JSON.parse data
    ).connect()

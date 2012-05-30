class @EndlessScroller

  constructor: (collection, options) ->
    @collection = collection
    @options    = options
    @window     = $(options.window)
    @list       = $(options.list)
    @fetchOn    = true
    @page       = 1
    @window.scroll @scroll

  scroll: =>
    if @isOnBottom() and @fetchOn
      lastModel = @collection.last()
      return unless lastModel?
      @fetchOn = off
      @collection.fetch
        success : @fetchSuccess
        error   : @fetchError
        add     : true
        data    : @buildQuery()

  fetchSuccess: (collection, response) =>
    @fetchOn = on
    @page += 1
    @options.success(collection, response) if @options.success

  fetchError: (collection, response) =>
    @fetchOn = on
    @options.error(collection, response)

  buildQuery: ->
    params = {}
    params['page'] = @page + 1
    params

  isOnBottom: ->
    if $(@window).scrollTop() > $(@list).height() - $(@window).height() - 50
      true
    else
      false

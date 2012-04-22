class @FormHelper

  constructor: (@model, @errors, @options) ->
    if @options? and @options['name']?
      @name = @options['name']
    else
      throw new Error 'Please set name for model.'

  label: (attr, title, options={}) ->
    if _.isObject(title)
      [title, options] = [@attr2name(attr), title]
    JST['form_helper/templates/label'] @basics4attr(attr, title, options)

  text_field: (attr, title, options={}) ->
    if _.isObject(title)
      [title, options] = [@attr2name(attr), title]
    JST['form_helper/templates/text_field'] @basics4attr(attr, title, options)

  select: (attr, choices, html_options={}) ->

  #
  #
  #
  field_id: (attr) ->
    "#{@name}_#{attr}"

  field_name: (attr) ->
    "#{@name}[#{attr}]"

  unfold_options: (options) ->
    unfolded = for key, value of options
      "#{key}=\"#{value}\""
    unfolded.join(' ')

  attr2name: (attr) ->
    attr = @capitalize attr
    attr = attr.replace /_/g, ' '
    attr

  basics4attr: (attr, title, options) ->
    attrs =
      title: title
      unfold_options: @unfold_options options
      field_id: @field_id(attr)
      field_name: @field_name(attr)
      value: @model.get attr
      errors: @errors?[attr]
    attrs.title ||= @attr2name attr
    attrs

  capitalize: (str) ->
    str.charAt(0).toUpperCase() + str.slice(1);

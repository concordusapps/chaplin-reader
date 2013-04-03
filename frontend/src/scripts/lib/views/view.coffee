_ = require 'underscore'
{View} = require 'chaplin'

module.exports = class View extends View

  # Default the container to be the body.
  container: 'body'

  #! Extend this to provide the precompiled template.
  #! eg. `template: require 'templates/index'`
  template: -> ''

  getTemplateFunction: ->
    # Return the template function to hook into
    # chaplin's template system.
    @template

  render: ->
    super

    # Apply basic stickit bindings.
    @stickit() if @bindings and @model

  #! Context data to be given to the template as stickit
  #! handles all of the model <-> view binding.
  context: null

  getTemplateData: ->
    # Hooks into the chaplin template rendering process.
    yea = _.result this, 'context'
    console.log yea
    yea

{CollectionView} = require 'chaplin'

module.exports = class CollectionView extends CollectionView

  # Default the container to be the body.
  container: 'body'

  #! Extend this to provide the precompiled template.
  #! eg. `template: require 'templates/index'`
  template: -> ''

  getTemplateFunction: ->
    # Return the template function to hook into
    # chaplin's template system.
    @template

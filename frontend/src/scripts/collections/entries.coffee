{Collection} = require 'chaplin'
Entry = require 'models/entry'

module.exports = class Entries extends Collection

  model: Entry

  initialize: (models, options = null) ->
    super
    @feed = options.parent

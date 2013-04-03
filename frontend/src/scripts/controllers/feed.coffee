_ = require 'underscore'
{Controller} = require 'chaplin'
View =
  Entries: require 'views/entries'
  Entry: require 'views/entry'
Feed = require 'models/feed'

module.exports = class Index extends Controller

  beforeAction:
    '.*': (params, route, options) ->
      console.log 'WHAT?!'
      deferred = false
      params = _.pick params, ['host', 'path']
      @compose 'syndication', (params), ->
        @model = new Feed null, data:
          host: params.host
          path: params.path

        deferred = @model.fetch()
      deferred

  show: (params, route, options) -> # ...
    @view = new View.Entries
      collection: @compose('syndication').model.entries
      autoRender: true

  item: (params, route, options) ->
    @view = new View.Entry
      model: @compose('syndication').model.entries.get params.id
      autoRender: true

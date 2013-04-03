_ = require 'underscore'
$ = require 'jquery'
{Model} = require 'chaplin'
Entry = require 'models/entry'
Entries = require 'collections/entries'

module.exports = class Feed extends Model

  url: '/api'

  data: null

  initialize: (attributes, options = {}) ->
    # Store the server-side data filters.
    @data = options.data if options.data

  fetch: (options = {}) ->
    # Apply server-side data filtering.
    options.data = _.defaults {}, options.data, @data

    # Forward to backbone to finish the request.
    super options

  sync: (method, model, options = {}) ->
    # Ensure we're talking XML.
    options.dataType = 'xml'

    # Forward to backbone to finish the request.
    super method, model, options

  _parse_atom: ($feed) ->
    # Initialize the attribute context.
    attributes = {}

    # Parse out the core attributes that
    # describe a feed.
    attributes.title = $feed.children('title').text()
    attributes.updated = $feed.children('updated').text()

    # Parse and collect the entries contained within the
    # feed.
    items = for item in $feed.children('entry')
      new Entry item, {parse: true}

    # Store the entries in a collection.
    @entries = new Entries items, parent: this

    # Return the constructed attributes.
    attributes

  _parse_rss: ($channel) ->
    # Initialize the attribute context.
    attributes = {}

    # Parse out the core attributes that describe the channel.
    attributes.title = $channel.children('title')
    attributes.updated = $channel.children('lastBuildDate').text()

    # Parse and collect the entries contained within the
    # feed.
    items = for item in $channel.children('item')
      new Entry item, {parse: true}

    # Store the entries in a collection.
    @entries = new Entries items, parent: this

    # Return the constructed attributes.
    attributes

  parse: (document) ->
    # Attempt to parse feed as ATOM
    $feed = $(document).children('feed')
    return @_parse_atom($feed) if $feed.length

    # Attempt to parse feed as RSS
    $channel = $(document).children('rss').children('channel')
    return @_parse_rss($channel) if $channel.length

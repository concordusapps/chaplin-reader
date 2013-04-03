_ = require 'underscore'
$ = require 'jquery'
{Model} = require 'chaplin'

module.exports = class Entry extends Model

  _parse_atom: ($entry) ->
    # Initialize the attribute context.
    attributes = {}

    # Parse out the core attributes that
    # describes an entry.
    attributes.title = $entry.children('title').text()
    attributes.content = $entry.children('content').text()
    attributes.published = $entry.children('published').text()
    attributes.id = window.btoa $entry.children('id').text()

    # Return the constructed attributes.
    attributes

  _parse_rss: ($entry) ->
    # Initialize the attribute context.
    attributes = {}

    # Parse out the core attributes that
    # describes an entry.
    attributes.title = $entry.children('title').text()
    attributes.content = $entry.children('description').text()
    attributes.published = $entry.children('pubDate').text()

    # Hash the guid as it could be anything (in order to display something
    # that looks like an identifier in the URL).
    attributes.id = window.btoa $entry.children('guid').text()
    console.log attributes.id

    # As RSS defines no protocol for a subtitle; truncate the
    # description at 60 characters.
    attributes.subtitle = _.prune attributes.content, 60

    # Look for extended content.
    content = $entry.children('description + *')
    if _.startsWith content[0].nodeName, 'content'
      # Found something interesting
      attributes.content = content.text()

    # Return the constructed attributes.
    attributes

  parse: (entry) ->
    # TODO: Support <rss /> specification
    $entry = $(entry)
    return @_parse_atom($entry) if $entry.is('entry')
    return @_parse_rss($entry) if $entry.is('item')

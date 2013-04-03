View = require 'lib/views/view'
moment = require 'moment'


module.exports = class Entry extends View

  template: require 'templates/entry'

  id: 'entry'

  bindings:
    '.title': 'title'
    '.published':
      observe: 'published'
      onGet: (value) ->
        moment(value).fromNow()

    '.content':
      observe: 'content'
      updateMethod: 'html'
      escape: false

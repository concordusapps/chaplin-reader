View = require 'lib/views/view'
CollectionView = require 'lib/views/collection_view'
moment = require 'moment'

class Entry extends View

  template: require 'templates/entries/entry'

  tagName: 'li'

  bindings:
    '.title': 'title'
    '.published':
      observe: 'published'
      onGet: (value) ->
        moment(value).fromNow()

    '.subtitle':
      observe: 'subtitle'
      updateMethod: 'html'
      escape: false

  events:
    'click': ->
      @publishEvent '!router:route', "/feed/#{ @model.get 'id' }"


module.exports = class Entries extends CollectionView

  template: require 'templates/entries'

  id: 'entries'

  listSelector: '.items'

  itemView: Entry

  animationDuration: 150

View = require 'lib/views/view'

module.exports = class Index extends View

  template: require 'templates/index'

  context:
    targets: [
      name: 'Ars Technica'
      host: 'feeds.arstechnica.com'
      path: window.encodeURIComponent '/arstechnica/index?format=xml'
    ,
      name: 'Concordus Applications'
      host: 'blog.concordusapps.com'
      path: window.encodeURIComponent '/feed/'
    ,
      name: 'Flickr'
      host: 'api.flickr.com'
      path: window.encodeURIComponent '/services/feeds/photos_public.gne'
    ]

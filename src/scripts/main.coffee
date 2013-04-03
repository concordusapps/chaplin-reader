require.config
  paths:
    # jQuery is a fast, small, and feature-rich JavaScript library. It makes
    # things like HTML document traversal and manipulation, event handling,
    # animation, and Ajax much simpler with an easy-to-use API that works
    # across a multitude of browsers.
    # http://api.jquery.com/
    jquery: "/components/jquery/jquery"

    # Backbone.js gives structure to web applications by providing models
    # with key-value binding and custom events, collections with a rich
    # API of enumerable functions, views with declarative event handling,
    # and connects it all to your existing API over a RESTful
    # JSON interface.
    # http://backbonejs.org/
    backbone: "/components/backbone/backbone"

    # A utility-belt library for JavaScript that provides a lot of the
    # functional programming support.
    # http://underscorejs.org/
    underscore: "/components/underscore/underscore"

    # Haml (HTML abstraction markup language) is based on one primary
    # principle: markup should be beautiful.
    # https://github.com/netzpirat/haml-coffee
    haml: 'lib/haml'

    # Chaplin.js; Web application framework on top of Backbone.js.
    # https://github.com/chaplinjs/chaplin
    chaplin: '/components/chaplin/amd/chaplin'

    # Moment.js for manipulating date/time.
    # http://momentjs.com/docs/
    moment: "/components/moment/moment"

  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'

    underscore:
      exports: '_'

require ['app'], (Application) ->
  # Instantiate the application and begin the execution cycle.
  app = new Application()
  app.initialize()

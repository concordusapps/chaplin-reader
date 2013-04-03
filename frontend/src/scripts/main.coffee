require.config
  map:
    '*':
      backbone: 'components/backbone'
      underscore: 'components/underscore'

    'components/backbone':
      backbone: '_backbone'

    'components/underscore':
      underscore: '_underscore'

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
    _backbone: "/components/backbone/backbone"

    # Stickit is a Backbone data binding plugin that binds Model attributes
    # to View elements with a myriad of options for fine-tuning a
    # rich app experience.
    # http://nytimes.github.com/backbone.stickit/
    'backbone-stickit': "/components/backbone.stickit/backbone.stickit"

    # A utility-belt library for JavaScript that provides a lot of the
    # functional programming support.
    # http://underscorejs.org/
    _underscore: "/components/underscore/underscore"

    # Underscore.string is JavaScript library for comfortable
    # manipulation with strings.
    # https://github.com/epeli/underscore.string#string-functions
    'underscore-string': "/components/underscore.string/lib/underscore.string"

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
    _backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'

    _underscore:
      exports: '_'

    'backbone-stickit':
      deps: ['_backbone']
      exports: 'Backbone.Stickit'

    'underscore-string':
      exports: '_.str'

require ['app'], (Application) ->
  # Instantiate the application and begin the execution cycle.
  app = new Application()
  app.initialize()

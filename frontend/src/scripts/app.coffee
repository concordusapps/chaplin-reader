{Application} = require 'chaplin'
mediator = require 'lib/mediator'
routes = require 'routes'

module.exports = class Application extends Application

  initialize: ->
    # Initialize the various chaplin modules here.
    # The dispatcher handles initialziation and diposal of
    # controllers.
    @initDispatcher controllerSuffix: ''

    # The router handles receiving URLs and sending them off to
    # registered controller actions. The router can additionally
    # reverse an appropriate URL from its correspond controller action or
    # a given name.
    @initRouter routes

    # The layout is a top-level view in charge of managing application wide
    # events or regions. It also handles the internal routing of anchor
    # tags to the router module.
    @initLayout()

    # The composer handles the management of compositions which can be
    # models, views, etc. that may exist beyond one route.
    @initComposer()

    # The mediator is a global event object for pub / sub messaging as well
    # as a semi-global store of information.
    @initMediator()

    # Freeze the object instance; prevent further changes.
    Object.freeze? @

    # This method initiates the routing by taking the current URL and
    # matching it against a defined route, if any.
    @startRouting()

  initMediator: ->
    # Attach any semi-globals here to the mediator for reference and use
    # by the rest of the application.

    # Sealing the mediator here prevents the rest of the application from
    # attaching additional global variables; hence, 'semi'-global store.
    mediator.seal()

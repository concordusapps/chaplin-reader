{Controller} = require 'chaplin'
View = require 'views/index'

module.exports = class Index extends Controller

  show: ->
    @view = new View {autoRender: true}

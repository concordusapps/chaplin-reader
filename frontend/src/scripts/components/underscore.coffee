# Require the base module.
require 'underscore'

# Grab the object.
_ = window._

# Require any additional modules; attaching as neccesary.
_.str = require 'underscore-string'
_.mixin _.str

# Return the object.
module.exports = _

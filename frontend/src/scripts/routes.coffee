module.exports = (match) ->
  match '', 'index#show'
  match 'feed', 'feed#show'
  match 'feed/*id', 'feed#item'

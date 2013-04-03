require('http-proxy').createServer(function (req, res, proxy) {
  var query = require('url').parse(req.url, true).query;
  if (!query.host) return res.end();
  req.url = query.path || '/';
  req.headers.host = query.host
  proxy.proxyRequest(req, res, {
    host: query.host,
    port: query.port || 80
  });
}).listen(8000);

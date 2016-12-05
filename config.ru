require 'rack/lobster'

map '/health' do
  health = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["1"]]
  end
  run health
end

map '/lobster' do
  run Rack::Lobster.new
end

map '/' do
  doc = proc do |env|
    content = [
      "<!doctype html><html><body><p><pre>",
      env['HTTP_X_FORWARDED_FOR'],
      "</pre></body></html>"
    ].join
    [200, { "Content-Type" => "text/html" }, [content]]
  end
  run doc
end

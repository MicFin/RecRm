#https://github.com/carstengehling/route_downcaser

RouteDowncaser.configuration do |config|

  # With this configuration option set to `true`, the middleware will 301 redirect all routes to their downcased version. Example: `localhost:3000/Foo` will redirect to `localhost:3000/foo`.
  config.redirect = true

  # Array of regular expressions. If the requested path matches one of these expressions, RouteDowncaser will not change anything.
  # Images are a good one to exclude to not mess up naming structure
  config.exclude_patterns = [
    /assets\//i,
    /fonts\//i,
    /images\//i
  ]
end
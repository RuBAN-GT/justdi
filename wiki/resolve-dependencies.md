# Resolve dependencies

If you decide to follow the IOC approach you should define your entrypoint to your application.
The best way for that is to use `resolve` interface of a container instance under your application class.

```ruby
class Application
  extend Justdi::Injectable
  dependency :logger, destination: :method
  dependency :server, destination: :method

  def run
    logger.info('Application is started')
    server.start
  end
end

app = container.resolve(Application)
app.run
```

This method works using `Justdi::ClassResolver` mechanism. You can find more example in sources or spec.

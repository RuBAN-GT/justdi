# Inject dependencies

You can declare requiring class dependencies and inject them using `Justdi::Injectable` module.

This module provides `dependency` interface helping to declare required dependency and approach describing how to use inject it.

```ruby
class Orm; end
class Repository
  extend Justdi::Injectable
  dependency :orm

  attr_reader :orm

  def initialize(orm)
    @orm = orm
  end
end

container.register(:orm).use_class(Orm) }
container.resolve(Repository).orm # => #<Orm>
```

## Injectable approaches.

If you want to specify which approach to use for injection use `destination` key as a second method argument.

### Constructor

`:initializer` (default) - inject dependency into class initializer.

### Instance method

`:method` - define method forwarding to resolved dependency

```ruby
class Orm; end
class Repository
  extend Justdi::Injectable
  dependency :orm, destination: :method
end

container.register(:orm).use_class(Orm) }
repo = container.resolve(Repository)
repo.orm # => #<Orm>
```

### Class object method

`:class_method` - define class object (static) method forwarding to resolved dependency.

```ruby
class Orm; end
class Repository
  extend Justdi::Injectable
  dependency :orm, destination: :method
end

container.register(:orm).use_class(Orm) }
repo = container.resolve(Repository).orm # doesn't affect to original parent class
repo.class.orm # => #<Orm>
```

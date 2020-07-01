# Container initialization

## Default container

If you want to initialize your basic container, just create
`Justdi::Container` instance and use for you tasks without fear.

```ruby
container = Justdi::Container.new

container.set(:orm).use_class(CustomOrm)
container.get(:orm) # => #<CustomOrm:0x0000000000000000>
```

## Custom container

Any container - is a simple wrapper over storage of dependencies (`Justdi::DefinitionStore`) and their resolver (`Justdi::Resolver`).

If you want to customize default storaging or resolving logic,
you can inherit your own class from `Justdi::Container` like this:

```ruby
class CustomContainer < Justdi::Container
  use_store    CustomStore # Should be compatible with Justdi::DefinitionStore
  use_resolver CustomResolver # Should be compatible with Justdi::Resolver
end
```

Now, for example your `CustomContainer` `get/[]`, methods will forward to `CustomStore`,
resolving functionality will use `CustomResolver`.

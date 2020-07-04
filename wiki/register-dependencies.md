# Register dependencies

Justdi container provides functionality to store entries with specific declaration.

Each container entry should have metadata:
* **type** as symbol, you can use constants from `Justdi::Definition` class.
* **value** used by resolver from container.

From the box Justdi supports the several typed entries:

* `static` - simple constant without any mutations.
* `class` - sample of class required to generate injected instances.
* `factory` - proc helping to generate container values.

You can define and pass them into container following different ways.

## Manual

The one from available ways to set entry is to use `set` or `[]=` interfaces.

```ruby
container.set :example, type: Justdi::Definition::STATIC, value: 42 # you can use symbol type :static
container.get :example # => 42

container[:example] = { type: Justdi::Definition::STATIC, value: 47 } # the same behaviour
container.get :example # => 47
```

## Typed interfaces

When you use the above approach to register entries you should keep in mind which types should be defined.
If you contanier will try to resolve unknown type, you'll get `Justdi::UnknownDefinitionTypeError` exception.

To avoid these issues you can use `register` method:

```ruby
container.register(:example) # => Justdi::RegisterHandler instance binding to container storage.
```

`Justdi::RegisterHandler` provides interfaces to define entries for each types using simple methods:

```ruby
# equals for container.set(:constant_value, type: :static, value: 42)
container.register(:constant_value).use_value(42)

# equals for container.set(:class_value, type: :class, value: MyClass)
container.register(:class_value).use_class(MyClass)

# equals for container.set(:factroy_value, type: :factory, value: ->(_) { rand })
container.register(:factroy_value).use_factory(->(_) { rand }) # with lambda
container.register(:factroy_value).use_factory { |_| rand } # with Proc
```

You can find details about resolving logic at [Resolve dependencies](./resolve-dependencies.md) page

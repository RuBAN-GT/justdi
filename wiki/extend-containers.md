# Extend containers

You have different ways to export and extend container content.

## Merge containers

If you have a few existing containers you can merge them using `merge` method.

```ruby
container_a.merge container_b
```

From above example all entries from `container_b` will be imported
to `container_a` storage by overwritten duplicated keys.

## Import definition store

In some cases to have an ability to provide raw definition store
without resolved values is very useful, specially if you design a modular system.

Contanier instance can load it using `import_store` method following two strategies
with overwriting or preversing existing entries (`overwrite` option).

```ruby
def_store = Justdi::DefinitionStore.new
def_store.register(:example).use_value(42)

container.import_store(def_store)
container.get(:example) # => 42
```

# Justdi

Simple DI container

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'justdi'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install justdi
```

## TODO

* [ ] Doc
* [ ] Merge containers
* [ ] Thread-safe structures
* [ ] Self-definition like Angular providers

## Usage

### Container as register

```ruby
container = Justdi::Container.new

container.bind(:orm).use_class(CustomOrm)
container.get(:orm) # => #<CustomOrm:0x0000000000000000>
```

### IOC approach

```ruby
class Repository
  extend Justdi::Injectable
  dependency :orm

  attr_reader :orm

  def initialize(orm:)
    @orm = orm
  end

  def last(limit = 10)
    orm.find(limit: limit, order: [:updated_at, :DESC])
  end
end

repo = container.resolve(Repository) # => #<Repository:0x0000000000000000>
repo.last
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/justdi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/justdi/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Justdi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/justdi/blob/master/CODE_OF_CONDUCT.md).

# ViewComponent

View components for your Ruby applications.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'view_component'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install view_component
```


## Usage

### Declaring components

Create a new component by declaring a class that inherits from `ViewComponent`:

```ruby
class Header < ViewComponent
  props :label => String

  def render
    <<-HTML
      <h1>#{label}</h1>
    HTML
  end
end
```

Once defined, the component can be rendered:

```
puts Header.render(:label => "Welcome!")
```

Simple components can also be defined without having to use the `class` syntax:

```
Header = ViewComponent.new(:h1, :props => { :label => String }) { label }
```

These components have the same API as a class inheriting from `ViewComponent`,
so the sample component above can still be rendered the same way:

```
puts Header.render(:label => "Welcome!")
```


### Component properties

Components have the ability to declare the properties that they accept using
the `props` class method. This method accepts both the property's name and
their type. A `ViewComponent::TypeError` exception is raised when a component
is rendered with a property of the wrong type.

Property types may have the following forms:

- `T` for declaring a property of type `T`.
- `[T]` for declaring a property that must be an array containing `T` elements.
- `[T, V]` for declaring a property that must be of either type `T` or `V`.
  These are compound types.

Using compound type you can declare optional properties. For example, in `props
:label => [NilClass, String]`, `label` may be a string (`.render(:label =>
"hi")`), `nil` (`.render(:label => nil)`), or be left out, which is implicitly
`nil` (`.render`). A set of compound types already come with this gem for
convenience:

- `Boolean` which is defined as `[FalseClass, TrueClass]`
- `MaybeBoolean` which is defined as `[NilClass, FalseClass, TrueClass]`
- `MaybeHash` which is defined as `[NilClass, Hash]`
- `MaybeString` which is defined as `[NilClass, String]`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/minond/ruby-view_component.


## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

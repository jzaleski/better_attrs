# BetterAttrs

[![Build Status](https://secure.travis-ci.org/jzaleski/better_attrs.png?branch=master)](http://travis-ci.org/jzaleski/better_attrs)

Enhances `attr_accessor` and `attr_writer` to allow the specification of a callback to be invoked when an attribute value is changed.

Ideal for cascading updates or deployment scenarios where it is necessary to keep legacy values in sync until a time that they can be safely removed.

## Installation

Add this line to your application's Gemfile:

    gem 'better_attrs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_attrs

## Usage

The callback key is the attribute name, suffixed by either `_changed` or `_updated` (both behave identically).

In the examples below the callback (specified as `:foo_changed`) will be invoked when the value of `foo` changes.

A callback can be:

* a `lambda`
* a `proc`
* a `String` or `Symbol` (referring to a method)

In all cases the callback *must* be callable and *must* accept two arguments (the `old_value` and the `new_value` of the related attribute).

Adding a callback to an `attr_accessor` in new or existing class:

```ruby
class AnyClass
  attr_accessor :foo, :foo_changed => proc { |old_value, new_value| }
end
```

Adding a callback to an `attr_writer` in a new or existing class:

```ruby
class AnyClass
  attr_writer :foo, :foo_changed => proc { |old_value, new_value| }
end
```

## Contributing

1. Fork it (http://github.com/jzaleski/better_attrs/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

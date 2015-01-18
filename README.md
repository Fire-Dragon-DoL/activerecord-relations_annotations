# RelationsAnnotations

Annotate ActiveRecord relations objects with custom data, allowing metadata
on relations that can be used to customize code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-relations_annotations', '~> 0.0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-relations_annotations

## Usage

Not the greatest example, but gives you a rough idea:

```ruby
class User < ActiveRecord::base
  include ActiveRecord::RelationsAnnotations
end

users = User.where.not(email: nil)
with_email_users = users.annotate(:with_email? => true)
without_email_users = users.annotate(:with_email? => false)

if with_email_users.annotations.with_email?
  # Do some stuff
end

unless without_email_users.annotations.with_email?
  # Do other stuff on this group of users
end
```

Annotations can also be accessed in a hash-fashion, like on `OpenStruct`:

```ruby
users = User.where(email: 'foo').annotate(foo: 'bar')

users.annotations[:foo] # => 'bar'
users.annotations[:something] # => nil
```

## Documentation

`#annotate(**values)` accepts a hash, values are merged into the **annotations**
`OpenStruct`, it returns a new `ActiveRecord::Relation` based on the one is
called on.
If it's called as the first method (directly on model class), it behaves like
it's called on `all` method.

`annotations` method returns an `OpenStruct` with all annotations set on the
relation.

`annotated` method should not be used, basically ensures we are in an
`ActiveRecord::Relation` and ensures the annotations `OpenStruct` exists, so
even in case it's called, it won't do any damage.

## Features

### Chainable

```ruby
User.where.not(email: 'foo').
  annotate(testme: 123, blah: 'hi').
  annotate(foo: 'bar').
  where(something: 'else').
  annotations
# => <OpenStruct testme=123, blah='hi', something='else'>
```

### Always returns an OpenStruct

```ruby
User.annotations
# => <OpenStruct>
```

```ruby
User.where.not(email: 'foo').annotations
# => <OpenStruct>
```

### It always creates a relation

```ruby
User.annotate(foo: 'bar').class
# => User::ActiveRecord_Relation
```

## Gotchas

When you call methods on relations, they create new values, much like `map` for
array, which creates a new array.
This means the following:

```ruby
tmp = User.where.name(email: 'foo')

tmp2 = tmp.annotate(bar: 'baz')

tmp.annotations # => <OpenStruct>
tmp2.annotations # => <OpenStruct bar='baz'>
```

It shouldn't be a problem, though, because it's standard
`ActiveRecord::Relation` behavior.

## How it works
Functionality is simple, the only _hack_ is that when `annotate`, `annotated`
and `annotations` are called, a instance variable is created (if missing),
called `@_annotations` and it's used to read values, through
`instance_variable_set` and `instance_variable_get`.

## Contributing

1. Fork it ( https://github.com/Fire-Dragon-DoL/activerecord-relations_annotations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

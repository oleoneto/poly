# Poly
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'poly'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install poly
```

### Install in your application
This step will copy all the migrations.
```bash
$ rails g poly:install
```

Add the routes to your application
```ruby
Rails.application.routes.draw do
    mount Poly::Engine => "/poly"
end
```

Create a `Procfile`:
```
web: bin/rails server -p 5003
css: yarn compile:css --watch --minify
js: yarn compile:js --watch
sidekiq: bundle exec sidekiq -r ./sandbox/config/environment.rb
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

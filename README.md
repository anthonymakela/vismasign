# Ruby gem for Visma Sign's API

Ruby gem to support digital signatures utilizing the services provided by Visma. The users of Visma Sign can sign documents with strong identification (local BankID/NemID codes) in Finland, Norway, Sweden and Denmark. The API is available globally, but signers need Finnish, Swedish, Danish or Norwegian banking or mobile authentication credentials.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vismasign'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install vismasign

## Usage

To access the API you'll need the identifier and an api key from Visma. After recieving your credentials you can access the resources with

```ruby
client = Vismasign::Client.new(identifier: ENV["IDENTIFIER"], api_key: ENV["API_KEY"])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vismasign. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/vismasign/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vismasign project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vismasign/blob/master/CODE_OF_CONDUCT.md).

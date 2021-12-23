# Ruby gem for Visma Sign's API

Ruby gem to support digital signatures utilizing the services provided by Visma. The users of Visma Sign can sign documents with strong identification (local BankID/NemID codes) in Finland, Norway, Sweden and Denmark. The API is available globally, but signers need Finnish, Swedish, Danish or Norwegian banking or mobile authentication credentials.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vismasign', github: "anthonymakela/vismasign"
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

## Document

To create a new document you can call the `create` method as follows

```ruby
client.document.create(document: { "name": "Test document" })
```

You can find the params for the create method from the [docs](https://sign.visma.net/api/docs/v1/#action-document-create).

Following the signin process you can add a file to the created document with

```ruby
client.document.add_file(document_id: xxx, file_url: xxx)
```

note that the gem currently only supports files to be uploaded from a given url.


Visma has an endpoint to fetch the status for a single document however, this will return more than just the status so we will refer to this as __retrieving__ a document. You can do this by calling

```ruby
client.document.retrieve(document_id: xxx)
```

To get the status of a document you can call the `status` method which will return a string

```ruby
client.document.status(document_id: xxx) # e.g "pending" 
```

## Invitation

To send the signatures after you've created the document and added the file to be signed you can use the `create` method for the invitation resource as follows

```ruby
client.invitation.create([ { "email": "foo@example.com"}, { "email": "bar@example.com"} ], document_id: xxx)
```
note that the first argument to the `create` method expects an array of hashes. You can find more information about the arguments for the invitations from the [docs](https://sign.visma.net/api/docs/v1/#action-document-create-invitations).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vismasign. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/vismasign/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vismasign project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vismasign/blob/master/CODE_OF_CONDUCT.md).

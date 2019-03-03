# Tibetan -> Wylie

Romanization of Tibetan. It transliterates Tibetan text to the Latin script using THL EWTS (Extended Wylie Transliteration Scheme).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tibetan'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tibetan

## Usage

```ruby
require "tibetan"
```

And then

```ruby
Tibetan.transliterate("བོད་སྐད་") # => "bod skad"
Tibetan.transliterate("༡༢༣") # => "123"
Tibetan.transliterate("༪") # => "0.5"
```
or

```ruby
Tibetan.t("བོད་སྐད་") # => "bod skad"
Tibetan.t("༡༢༣") # => "123"
Tibetan.t("༪") # => "0.5"
```

## References
http://www.thlib.org/reference/transliteration/#!essay=/thl/ewts/meta/
http://www.thlib.org/reference/transliteration/teachingewts.pdf
http://www.thlib.org/reference/transliteration/phconverter.php
https://www.unicode.org/charts/PDF/U0F00.pdf
http://tibetan.spb.ru/lessons/wylie.phtml
https://github.com/gitpan/App-Lingua-BO-Wylie-Transliteration
https://github.com/BlueVajra/Wylie


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rovetz/tibetan. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tibetan project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rovetz/tibetan/blob/master/CODE_OF_CONDUCT.md).

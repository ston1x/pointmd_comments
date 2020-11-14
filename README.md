# PointmdComments
pointmd_comments is a Ruby gem designed for parsing and aggregating comments from point.md website into a CSV file.

## Installation

### Prerequisites
1. Install RVM
https://rvm.io/rvm/install

2. Install chromedriver

  **macOS**:

  ```sh
  brew cask install chromedriver
  ```

  **Ubuntu**:
  ```sh
  sudo apt-get update && apt-get install chromium-chromedriver
  ```

3. Install the gem
  ```sh
  gem install pointmd_comments
  ```

## Usage

### Run from shell

  To aggregate comments and save them into a CSV within current directory:
  ```sh
  pointmd_comments
  ```
  Or, if you want to save the output CSV to a specific path:
  ```sh
  pointmd_comments -o ~/my_output.csv
  ```

  If you want pointmd_comments to be more verbose, use the `-v` flag:
  ```sh
  pointmd_comments -v
  ```

  For general help:
  ```sh
  pointmd_comments --help
  ```

### Run from Ruby code
```ruby
require 'pointmd_comments'

PointmdComments.collect

# Or, if you want to specify an output path:
PointmdComments.collect(output: '~/my_output.csv')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ston1x/pointmd_comments. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pointmd_comments/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PointmdComments project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pointmd_comments/blob/master/CODE_OF_CONDUCT.md).

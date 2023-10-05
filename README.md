# Terminal Progress

[![Gem (including prereleases)](https://img.shields.io/gem/v/terminal-progress?label=gem%20version&color=44cc11)](https://rubygems.org/gems/terminal-progress)
[![GitHub Packages](https://img.shields.io/badge/github_packages-v0.1.0.2-44cc11.svg?v=1696463352)](https://github.com/Okomikeruko/terminal-progress/packages)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Okomikeruko/terminal-progress/blob/master/LICENSE)

Terminal Progress is a versatile and customizable progress bar manager for Ruby
applications. It provides an elegant and interactive way to display progress
updates in the terminal, making it ideal for tasks like seed data generation,
file processing, or any operation where progress tracking is crucial.

## Features

- **Interactive Progress Bars:** Enhance your terminal applications with dynamic progress bars that keep users informed about ongoing tasks.

- **Customization:** Terminal Progress offers a wide range of customization options, including colors and animations, allowing you to tailor the progress bars to your project's style.

- **Ease of Use:** Integrate Terminal Progress seamlessly into your Ruby projects. It's beginner-friendly and designed to make progress tracking a breeze.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terminal-progress', '~> 0.1.0'
```

And then execute

```console
bundle install
```

Or install it globally with:

```console
gem install terminal-progress
```

## Usage

Here's a quick example of how to use Terminal Progress in your Ruby application:

```ruby
require 'terminal-progress'

# Create a new progress bar with a maximum value
progress_bar = TerminalProgress.new(100)

# Update and display the progress bar
(0..100).each do |i|
  progress_bar.print_progress("Processing item #{i}")
  sleep(0.1)
end

# Complete the progress and clean up
progress_bar.print_complete
```

## Contributing

Bug reports and pull requests are welcome on GitHub at our
[Terminal Progress Repository](https://github.com/Okomikeruko/terminal-progress).

## License

Terminal Progress is available as open-source software under the
[MIT License](https://github.com/Okomikeruko/terminal-progress/blob/master/LICENSE).


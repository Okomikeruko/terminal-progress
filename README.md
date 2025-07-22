# Terminal Progress
[![Gem (including prereleases)](https://img.shields.io/gem/v/terminal-progress?label=gem%20version&color=44cc11)](https://rubygems.org/gems/terminal-progress)
[![GitHub Packages](https://img.shields.io/badge/github_packages-v0.1.0.2-44cc11.svg?v=1696463352)](https://github.com/Okomikeruko/terminal-progress/packages)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Okomikeruko/terminal-progress/blob/master/LICENSE)

Terminal Progress is a Ruby gem that provides elegant progress bars for **countable tasks** - operations where you know how many items you need to process upfront. Perfect for database seeding, file processing, batch operations, and any task that involves iterating through a known collection.

## Features

- **Animated Braille Spinner:** Beautiful rotating animation that shows your process is actively running
- **Dynamic Progress Bar:** Automatically adapts to your terminal width with colored progress indicators
- **Step-by-Step Labels:** Display contextual messages only when needed (first iteration, milestones, etc.)
- **Automatic Calculation:** Just provide the total count - the gem handles percentage calculations internally
- **Clean Completion:** Proper cleanup and final status display

## When to Use Terminal Progress

✅ **Perfect for:**
- Processing lists of files, records, or items
- Database seeding operations
- Batch API calls
- Migration scripts
- Any task with a **known item count**

❌ **Not (currently) suitable for:**
- File downloads (unknown completion time)
- Streaming data (unknown total size)
- Tasks without a clear "total count"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'terminal-progress', '~> 0.1.0'
```

And then execute:
```console
bundle install
```

Or install it globally with:
```console
gem install terminal-progress
```

## Usage

### Basic Example

```ruby
require 'terminal-progress'

# Process a collection of items
users = User.all  # 1,000 users
progress = TerminalProgress.new(users.count)

users.each_with_index do |user, index|
  # Do your actual work
  user.send_welcome_email
  
  # Update progress (only show label on first item)
  progress.print_progress(index.zero? ? "Sending welcome emails" : nil)
end

progress.print_complete
```

**Output:**
```
  Sending welcome emails
  ⣯   423/1000: [==================                  ] 
```

### Database Seeding Example

```ruby
# Seed customers and orders
customers = 500
progress = TerminalProgress.new(customers + 100 + 50)  # Total operations

# Create customers
customers.times do |i|
  Customer.create!(name: "Customer #{i}")
  progress.print_progress(i.zero? ? "Creating customers" : nil)
end

# Create orders
100.times do |i|
  Order.create!(customer: Customer.all.sample)
  progress.print_progress(i.zero? ? "Creating orders" : nil)
end

# Send notifications
50.times do |i|
  send_notification
  progress.print_progress(i.zero? ? "Sending notifications" : nil)
end

progress.print_complete
```

### File Processing Example

```ruby
files = Dir.glob("data/*.csv")
progress = TerminalProgress.new(files.count)

files.each_with_index do |file, index|
  # Process each file
  CSV.foreach(file) { |row| process_row(row) }
  
  progress.print_progress(index.zero? ? "Processing CSV files" : nil)
end

progress.print_complete
```

## Key Concepts

- **Internal Counter:** The gem automatically tracks progress internally - just call `print_progress` once per item
- **Total Count:** Provide the total number of items upfront, not a measurement like file size
- **Label Strategy:** Only pass labels on first iterations to avoid terminal spam
- **Thread Safe:** The animated spinner runs in its own thread

## API Reference

### `TerminalProgress.new(max)`
Creates a new progress bar with the specified maximum count.

**Parameters:**
- `max` (Integer): Total number of items to process

### `print_progress(message = nil)`
Updates the progress bar and optionally displays a message.

**Parameters:**
- `message` (String, optional): Label to display above the progress bar

### `print_complete`
Finalizes the progress bar and cleans up resources. Always call this when finished.

## Contributing

Bug reports and pull requests are welcome on GitHub at our [Terminal Progress Repository](https://github.com/Okomikeruko/terminal-progress).

## License

Terminal Progress is available as open-source software under the [MIT License](https://github.com/Okomikeruko/terminal-progress/blob/master/LICENSE).

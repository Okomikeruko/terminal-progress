# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'terminal-progress'
  s.version = '0.1.0'
  s.licenses = ['MIT']
  s.authors = ['Lee Whittaker']
  s.description = <<-TEXT
    Terminal Progress is a progress bar manager for Ruby applications. It
    provides a simple way to display progress updates in the terminal, making
    it ideal for tasks like seed data eneration, file processing, or any
    operation where progress tracking is ideal.
  TEXT
  s.email = 'whittakerlee81@gmail.com'
  s.summary = <<-TEXT
    terminal-progress - Simplify progress tracking in your Ruby applications
    with this simple progress bar manager.
  TEXT
  s.homepage = 'https://github.com/Okomikeruko/terminal-progress'
  s.files = Dir['lib/**/*.rb']

  s.required_ruby_version = '>= 3.1'

  s.add_runtime_dependency 'colorize', '= 1.1.0'
  s.add_runtime_dependency 'curses', '= 1.4.4'

  s.add_development_dependency 'minitest', '= 5.20.0'
  s.add_development_dependency 'rubocop', '= 1.56.3'
  s.add_development_dependency 'stringio', '= 3.0.8'
end

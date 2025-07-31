# frozen_string_literal: true

require 'curses'
require 'colorize'

##
# Class for managing progress bars in the terminal
class TerminalProgress
  # Initialize a TermProg instance with a maximum value.
  #
  # @param max [Integer] The maximum value of the progress bar.
  def initialize(max)
    Curses.init_screen
    @cycle = '⣷⣯⣟⡿⢿⣻⣽⣾'.chars.cycle
    @i = 0
    @max = max
    @stop = '⣾'
    @loop = loop_thread
  end

  def loop_thread
    Thread.new do
      loop do
        instance_variable_set(:@stop, @cycle.next)
        printf "  #{@stop}\r"
        sleep 0.0625
      end
    end
  end

  ##
  # Increment the progress bar and print a message if present.
  #
  # @param message [String, nil] Optional message to display above the progress bar.
  def print_progress(message = nil)
    instance_variable_set(:@i, @max) if @i > @max
    printf "#{' ' * Curses.cols}\r#{message}\r\n" unless message.nil?
    print_line
    instance_variable_set(:@i, @i + 1)
  end

  ##
  # Print a single line of the progress bar.
  def print_line
    printf "#{prefix}#{'='.light_cyan * width}#{' ' * blank}#{suffix}\r"
  end

  ##
  # This is the last call to terminate the progress loop and finish rendering the bar.
  def print_complete
    kill
    printf "    #{@max}/#{@max}: [#{'='.light_yellow * width}#{suffix}\r\n"
  end

  # Call this to dynamically update the maximum value of the task bar.
  def update_max(new_max)
    raise ArgumentError, 'new_max must be positive' unless new_max.positive?

    @max = new_max
    @i = [@i, @max].min
  end

  # Call this to dynamically add a value to the maximum value of the task bar
  def add_to_max(num)
    raise ArgumentError, 'num must be positive' unless num.positive?

    @max += num
  end

  # Terminate the progress loop.
  def kill
    Thread.kill @loop
    Curses.close_screen
  end

  private

  # Generate the prefix of the progress bar.
  def prefix
    "  #{@stop} #{@i.to_s.rjust(@max.to_s.length)}/#{@max}: ["
  end

  # Calculate the maximum width for the progress bar.
  def max_width
    Curses.cols - prefix.length - suffix.length
  end

  # Calculate the current width of the progress bar.
  def width
    ((@i / @max.to_f) * max_width).to_i
  end

  # Calculate the number of blank spaces in the progress bar.
  def blank
    max_width - width
  end

  # Define the suffix of the progress bar.
  def suffix
    ']'
  end
end

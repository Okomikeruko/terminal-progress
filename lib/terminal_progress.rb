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
    Curses.raw
    instance_variable_set(:@cycle, '⣷⣯⣟⡿⢿⣻⣽⣾'.split(//).cycle)
    instance_variable_set(:@i, 0)
    instance_variable_set(:@max, max)
    instance_variable_set(:@stop, '⣾')
    instance_variable_set(:@loop, loop_thread)
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
    printf "    #{@max}/#{@max}: [#{'='.light_yellow * width}#{suffix}\r\n"
    kill
  end

  # Terminate the progress loop.
  def kill
    Thread.kill @loop
  end

  # Check if the progress loop is still alive.
  #
  # @return [Boolean] Returns true if the progress loop is alive, otherwise false.
  def alive?
    @loop.alive?
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

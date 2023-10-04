# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'
require 'terminal-progress'

class TestTerminalProgress < Minitest::Test
  def setup
    @term_prog = TerminalProgress.new(10)
  end

  def test_print_progress
    assert_output(%r{^\s+.\s+\d+/\d+:\s\[\S*\s*\]\r$}) do
      @term_prog.print_progress
    end
  end

  def test_print_progress_with_message
    assert_output(%r{^\s*\rTest Message\r\n\s*.\s*\d+/\d+: \[\S*\s*\]\r$}) do
      @term_prog.print_progress 'Test Message'
    end
  end

  def test_print_complete
    assert_output(%r{^\s+\d+/\d+: \[\S*\]\r\n$}) do
      @term_prog.print_complete
    end
  end

  def test_print_progress_generates_expected_output_during_loop
    expected_sequence = ['⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣽', '⣾']
    output_capturer = StringIO.new
    $stdout = output_capturer
    @term_prog.print_progress

    expected_sequence.each do |char|
      sleep 0.0625
      captured_output = output_capturer.string
      assert_match(/  #{Regexp.escape(char)}/, captured_output)
    end
  end

  def teardown
    $stdout = STDOUT
    @term_prog.kill if @term_prog.alive?
  end
end

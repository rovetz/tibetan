# frozen_string_literal: true

require "test_helper"

class UmaGlossariesTest < Minitest::Test
  FIXTURE_PATH = File.expand_path("fixtures/uma_glossaries.csv", __dir__)
  LINE_PATTERN = /^(?:"(?<en>.*?)"|(?<en>[^,]*)),(?<wylie>[^,]+),(?<tibetan>[^,]+),(?<sanskrit>.*)$/

  def test_transliteration_of_uma_glossaries
    File.foreach(FIXTURE_PATH).with_index do |line, idx|
      next if idx.zero?

      match = line.strip.match(LINE_PATTERN)
      next unless match

      wylie = match[:wylie].strip
      tibetan = match[:tibetan].strip

      assert_equal wylie, Tibetan.t(tibetan), "Mismatch on line #{idx + 1} for '#{tibetan}' (expected '#{wylie}')"
    end
  end
end

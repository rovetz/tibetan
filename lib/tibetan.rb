# frozen_string_literal: true

require "set"
require_relative "tibetan/version"

module Tibetan
  # Extended Wylie Transliteration Scheme (EWTS)
  CHARACTER_TABLE = {
    # Numbers
    "༠" => "0",
    "༡" => "1",
    "༢" => "2",
    "༣" => "3",
    "༤" => "4",
    "༥" => "5",
    "༦" => "6",
    "༧" => "7",
    "༨" => "8",
    "༩" => "9",
    # Half Numbers
    "༪" => "0.5",
    "༫" => "1.5",
    "༬" => "2.5",
    "༭" => "3.5",
    "༮" => "4.5",
    "༯" => "5.5",
    "༰" => "6.5",
    "༱" => "7.5",
    "༲" => "8.5",
    "༳" => "9.5",
    # Punctuation:
    "་" => " ",
    " " => "_",
    # Phrase Delimiting Marks
    "།" => "/",
    "༎" => "//",
    "༏" => ";",
    "༑" => "|",
    "༈" => "!",
    "༔" => ":",
    "༴" => "=",
    # Head Marks
    "༄" => "@",
    "༅" => "#",
    "༆" => "$",
    "༇" => "%",
    # Paired Punctuation Marks (brackets)
    "༺" => "<",
    "༻" => ">",
    "༼" => "(",
    "༽" => ")",
    "・" => " ",
    "《" => "\"",
    "》" => "\"",
    # Consonants, subjoined consonants
    "ཀ" => "k",
    "ྐ" => "k",
    "ཁ" => "kh",
    "ྑ" => "kh",
    "ག" => "g",
    "ྒ" => "g",
    "ང" => "ng",
    "ྔ" => "ng",
    "ཅ" => "c",
    "ྕ" => "c",
    "ཆ" => "ch",
    "ྖ" => "ch",
    "ཇ" => "j",
    "ྗ" => "j",
    "ཉ" => "ny",
    "ྙ" => "ny",
    "ཏ" => "t",
    "ྟ" => "t",
    "ཐ" => "th",
    "ྠ" => "th",
    "ད" => "d",
    "ྡ" => "d",
    "ན" => "n",
    "ྣ" => "n",
    "པ" => "p",
    "ྤ" => "p",
    "ཕ" => "ph",
    "ྥ" => "ph",
    "བ" => "b",
    "ྦ" => "b",
    "མ" => "m",
    "ྨ" => "m",
    "ཙ" => "ts",
    "ྩ" => "ts",
    "ཚ" => "tsh",
    "ྪ" => "tsh",
    "ཛ" => "dz",
    "ྫ" => "dz",
    "ཝ" => "w",
    "ྭ" => "w",
    "ཞ" => "zh",
    "ྮ" => "zh",
    "ཟ" => "z",
    "ྯ" => "z",
    "འ" => "'",
    "ྰ" => "'",
    "ཡ" => "y",
    "ྱ" => "y",
    "ར" => "r",
    "ྲ" => "r",
    "ལ" => "l",
    "ླ" => "l",
    "ཤ" => "sh",
    "ྴ" => "sh",
    "ས" => "s",
    "ྶ" => "s",
    "ཧ" => "h",
    "ྷ" => "h",
    "ཨ" => "a",
    "ྸ" => "a",
    # Retroflex Consonants
    "ཊ" => "T", "ྚ" => "T",
    "ཋ" => "Th", "ྛ" => "Th",
    "ཌ" => "Da", "ྜ" => "D",
    "ཎ" => "N", "ྞ" => "N",
    "ཥ" => "S", "ྵ" => "S",
    # Sanskrit Consonants
    "གྷ" => "gh", "ྒྷ" => "gh",
    "ཌྷ" => "Dh", "ྜྷ" => "Dh",
    "དྷ" => "dh", "ྡྷ" => "dh",
    "བྷ" => "bh", "ྦྷ" => "bh",
    "ཛྷ" => "dzh", "ྫྷ" => "dzh",
    "ྐྵ" => "kSh",
    # Sanskrit Signs
    "྅" => "`",
    "ཾ" => "ṃ",
    "ྃ" => "~ṃ",
    "ཿ" => "ḥ",
    # Vowels
    "ི" => "i",
    "ུ" => "u",
    "ེ" => "e",
    "ོ" => "o",
    # Sanskrit Vowels
    "ཱ" => "ā",
    "ཱི" => "ī",
    "ཱུ" => "ū",
    "ཻ" => "ai",
    "ཽ" => "au",
    "ྲྀ" => "ṛ",
    "ཷ" => "ṝ",
    "ླྀ" => "ḷ",
    "ཹ" => "ḹ"
  }.freeze

  CONSONANTS = %w[
    ཀ ཁ ག ང ཅ ཆ ཇ ཉ ཏ ཐ ད ན པ ཕ བ མ ཙ ཚ ཛ ཝ ཞ ཟ འ ཡ ར ལ ཤ ས ཧ ཊ ཋ ཌ ཎ ཥ གྷ ཌྷ དྷ བྷ ཛྷ
  ].freeze
  SUBSCRIPTS = %w[
    ྐ ྑ ྒ ྔ ྕ ྖ ྗ ྙ ྟ ྠ ྡ ྣ ྤ ྥ ྦ ྨ ྩ ྪ ྫ ྭ ྮ ྯ ྰ ྱ ྲ ླ ྴ ྶ ྷ ྚ ྛ ྜ ྞ ྵ ྒྷ ྜྷ ྡྷ ྦྷ ྫྷ ྐྵ
  ].freeze
  VOWELS = %w[ྸ ི ུ ེ ོ a].freeze
  SEP = "་"
  DEFAULT_VOWEL = "a"

  CONSONANTS_SUBSCRIPTS = (CONSONANTS + SUBSCRIPTS).freeze
  CONSONANTS_SUBSCRIPTS_SET = Set.new(CONSONANTS_SUBSCRIPTS).freeze

  SPLIT_REGEX = /([^#{Regexp.escape((CONSONANTS + SUBSCRIPTS + VOWELS).join)}]+)/
  A_CHUNG_REGEX = /([#{Regexp.escape(CONSONANTS_SUBSCRIPTS.join)}])འ/
  CHARACTER_TABLE_REGEX = /#{Regexp.union(CHARACTER_TABLE.keys).source}/i
  SUBSCRIPTS_REGEX = /[#{Regexp.escape(SUBSCRIPTS.join)}]/
  VOWELS_REGEX = /[#{Regexp.escape(VOWELS.join)}]/
  CONSONANTS_REGEX = /[#{Regexp.escape(CONSONANTS.join)}]/
  TRAILING_SPACES_REGEX = / +([»\])》"]|\Z)/

  class << self
    def transliterate(string = "", to = :tibetan)
      return "" if string.nil?

      string = string.to_s.dup
      return "" if string.empty?

      # Split long phrase into small parts and transliterate separately
      # Split by anything that isn't a Tibetan consonant, subscript, or vowel
      parts = string.split(SPLIT_REGEX).reject(&:empty?)
      if parts.size > 1
        res = parts.map do |str|
          transliterate(str, to)
        end.join
        # During mapping, trailing tseks become spaces. This cleans up erroneous spaces
        # before closing punctuation (e.g. «pe » -> «pe») and drops trailing spaces.
        res.gsub!(TRAILING_SPACES_REGEX, '\1')
        return res
      end

      # Implicit vowel 'a' before 'a-chung preceded by a consonant/subscript
      string.gsub!(A_CHUNG_REGEX, '\1aའ')

      insert_default_vowel!(string)

      # Exception: distinguish prefix 'g' and root 'y' (g.y) from root 'g' and subjoined 'y' (gy)
      string.gsub!("གཡ", "ག.ཡ")

      if to == :tibetan
        string.gsub(CHARACTER_TABLE_REGEX, CHARACTER_TABLE)
      else
        character_table = Module.const_get(to.to_s.capitalize)::CHARACTER_TABLE
        string.gsub(/#{Regexp.union(character_table.keys).source}/i, character_table)
      end
    end
    alias t transliterate

    private

    def insert_default_vowel!(string)
      return if VOWELS_REGEX.match?(string)

      if (sub_idx = string.rindex(SUBSCRIPTS_REGEX))
        string.insert(sub_idx + 1, DEFAULT_VOWEL)
      elsif CONSONANTS_REGEX.match?(string)
        # Count ONLY Tibetan consonants/subscripts to identify the root letter.
        # We ignore inline punctuation (like ») to avoid inflating the string size
        # and placing the implicit 'a' in the wrong position.
        tibetan_chars_count = 0
        string.each_char do |c|
          tibetan_chars_count += 1 if CONSONANTS_SUBSCRIPTS_SET.include?(c)
        end
        root_idx = tibetan_chars_count > 2 ? 1 : 0

        # Find the actual string index corresponding to the root consonant
        current = -1
        actual_index = -1
        string.each_char.with_index do |c, i|
          next unless CONSONANTS_SUBSCRIPTS_SET.include?(c)

          current += 1
          if current == root_idx
            actual_index = i
            break
          end
        end
        string.insert(actual_index + 1, DEFAULT_VOWEL) if actual_index >= 0
      end
    end
  end
end

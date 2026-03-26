# frozen_string_literal: true

require "tibetan/version"

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
    "༇" => "	%",
    # Paired Punctuation Marks (brackets)
    "༺" => "<",
    "༻" => ">",
    "༼" => "(",
    "༽" => ")",
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
    # Vowels
    "ི"  => "i",
    "ུ" => "u",
    "ེ"  => "e",
    "ོ"  => "o",
    # Sanskrit Vowels
    "ཱ"  => "ā",
    "ཱི"  => "ī",
    "ཱུ" => "ū",
    "ཻ"   => "ai",
    "ཽ"   => "au",
    "ྲྀ"  => "ṛ",
    "ཷ" => "ṝ",
    "ླྀ"  => "ḷ",
    "ཹ" => "ḹ",
  }
  
  CONSONANTS = %w(ཀ ཁ ག ང ཅ ཆ ཇ ཉ ཏ ཐ ད ན པ ཕ བ མ ཙ ཚ ཛ ཝ ཞ ཟ འ ཡ ར ལ ཤ ས ཧ ཊ ཋ ཌ ཎ ཥ)
  SUBSCRIPTS = %w(ྐ ྑ ྒ ྔ ྕ ྖ ྗ ྙ ྟ ྠ ྡ ྣ ྤ ྥ ྦ ྨ ྩ ྪ ྫ ྭ ྮ ྯ ྰ ྱ ྲ ླ ྴ ྶ ྷ ྚ ྛ ྜ ྞ ྵ)
  VOWELS = %w(ྸ  ི  ུ  ེ  ོ a)
  SEP = "་"
  DEFAULT_VOWEL = "a"

  class << self
    def transliterate(string="", to=:tibetan)
      string = string.to_s.dup
      
      # Split long phrase into small parts and transliterate separately
      # Split by anything that isn't a Tibetan consonant, subscript, or vowel
      parts = string.split(/([^#{CONSONANTS.join}#{SUBSCRIPTS.join}#{VOWELS.join}]+)/).reject(&:empty?)
      if parts.size > 1
        res = parts.map do |str|
          transliterate(str)
        end.join
        # During mapping, trailing tseks become spaces. This cleans up erroneous spaces 
        # before closing punctuation (e.g. «pe » -> «pe») and drops trailing spaces.
        res.gsub!(/ +([»\]\)]|\Z)/, '\1')
        return res
      end

      # Implicit vowel 'a' before 'a-chung preceded by a consonant/subscript
      string.gsub!(/([#{CONSONANTS.join}#{SUBSCRIPTS.join}])འ/, '\1aའ')

      insert_default_vowel!(string)

      # Exception: distinguish prefix 'g' and root 'y' (g.y) from root 'g' and subjoined 'y' (gy)
      string.gsub!("གཡ", "ག.ཡ")

      character_table = Module.const_get(to.to_s.capitalize)::CHARACTER_TABLE
      string.to_s.gsub(/#{Regexp.union(character_table.keys).source}/i, character_table)      
    end
    alias_method :t, :transliterate

    def insert_default_vowel!(string="")
      # 1. after subscript
      if (string.chars & VOWELS).empty?
        if (sub_idx = string.rindex(/#{SUBSCRIPTS.join('|')}/))
          string = string.insert(sub_idx+1, DEFAULT_VOWEL)
        elsif (string.chars & CONSONANTS).any?
          # 2. after consonant, if not added in 1st step
          # Count ONLY Tibetan consonants/subscripts to identify the root letter.
          # We ignore inline punctuation (like ») to avoid inflating the string size 
          # and placing the implicit 'a' in the wrong position.
          tibetan_chars_count = string.chars.count { |c| CONSONANTS.include?(c) || SUBSCRIPTS.include?(c) }
          root_idx = tibetan_chars_count > 2 ? 1 : 0
          
          # Find the actual string index corresponding to the root consonant
          current = -1
          actual_index = -1
          string.chars.each_with_index do |c, i|
            if CONSONANTS.include?(c) || SUBSCRIPTS.include?(c)
              current += 1
              if current == root_idx
                actual_index = i
                break
              end
            end
          end
          string = string.insert(actual_index+1, DEFAULT_VOWEL) if actual_index >= 0
        end
      end
    end
  end
end

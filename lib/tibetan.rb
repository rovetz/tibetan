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
  
  CONSONANTS = %w(ཀ ཁ ག ང ཅ ཆ ཇ ཉ ཏ ཐ ད ན པ ཕ བ མ ཙ ཚ ཛ ཝ ཞ ཟ འ ཡ ར ལ ཤ ས ཧ)
  SUBSCRIPTS = %w(ྐ ྑ ྒ ྔ ྕ ྖ ྗ ྙ ྟ ྠ ྡ ྣ ྤ ྥ ྦ ྨ ྩ ྪ ྫ ྭ ྮ ྯ ྰ ྱ ྲ ླ ྴ ྶ ྷ)
  VOWELS = %w(ྸ  ི  ུ  ེ  ོ a)
  SEP = "་"
  DEFAULT_VOWEL = "a"

  class << self
    def transliterate(string="", to=:tibetan)
      string = string.to_s
      
      # Split long phrase into small parts and transliterate separately
      if string.split(SEP).size > 1
        string = string.split(SEP).map do |str|
          transliterate(str)
        end.join(SEP)
      end
      
      insert_default_vowel!(string)

      character_table = Module.const_get(to.to_s.capitalize)::CHARACTER_TABLE
      string.to_s.gsub(/#{Regexp.union(character_table.keys).source}/i, character_table)      
    end
    alias_method :t, :transliterate

    def insert_default_vowel!(string="")
      # 1. after subscript
      if (string.chars & VOWELS).empty?
        index = string.rindex(/#{SUBSCRIPTS.join('|')}/)
        string = string.insert(index+1, DEFAULT_VOWEL) unless index.nil?
      end
      # 2. after consonant, if not added in 1st step
      if (string.chars & VOWELS).empty? && (string.chars & CONSONANTS).any?
        index = string.size > 2 ? 1 : 0
        string = string.insert(index+1, DEFAULT_VOWEL) unless index.nil?
      end
    end
  end
end

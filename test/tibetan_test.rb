require "test_helper"

class TibetanTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tibetan::VERSION
  end

  def test_it_transliterates_tibetan
    assert_equal "bod ", Tibetan.t("བོད་")
    assert_equal "skad ", Tibetan.t("སྐད་")
    assert_equal "bod skad", Tibetan.t("བོད་སྐད་")
    # TODO: support Sanskrit symbols
    # assert_equal "shuddho`haṃ", Tibetan.t("ཤུདྡྷོ྅ཧ")

    # COMBINATIONS
    assert_equal "lo", Tibetan.t("ལོ")
    assert_equal "bu", Tibetan.t("བུ")
    assert_equal "re", Tibetan.t("རེ")
    assert_equal "ba", Tibetan.t("བ")
    assert_equal "mi", Tibetan.t("མི")
    assert_equal "tsho", Tibetan.t("ཚོ")
    assert_equal "du", Tibetan.t("དུ")
    assert_equal "ri", Tibetan.t("རི")
    assert_equal "jo", Tibetan.t("ཇོ")
    assert_equal "bo", Tibetan.t("བོ")
    assert_equal "de", Tibetan.t("དེ")
    assert_equal "su", Tibetan.t("སུ")
    assert_equal "'o", Tibetan.t("འོ")

    # Syllable Elements 
    assert_equal "gya", Tibetan.t("གྱ")
    assert_equal "gyang", Tibetan.t("གྱང")
    
    # THE SHAD
    assert_equal "rta/", Tibetan.t("རྟ།")
    assert_equal "nor/", Tibetan.t("ནོར།")
    assert_equal "lug gsum/", Tibetan.t("ལུག་གསུམ།")
    assert_equal "ri mgo na nyal na dka'/", Tibetan.t("རི་མགོ་ན་ཉལ་ན་དཀའ།")
    assert_equal "gcig", Tibetan.t("གཅིག")
    
    assert_equal "bsal ", Tibetan.t("བསལ་")
    assert_equal "spyir ", Tibetan.t("སྤྱིར་")
    assert_equal "dmigs ", Tibetan.t("དམིགས་")
    assert_equal "gros ", Tibetan.t("གྲོས་")
    assert_equal "blang ", Tibetan.t("བླང་")

    assert_equal "srid pa", Tibetan.t("སྲིད་པ་")
    assert_equal "'jigs med", Tibetan.t("འཇིགས་མེད་")
    assert_equal "dge 'dun", Tibetan.t("དགེ་འདུན་")
    assert_equal "tshogs chen", Tibetan.t("ཚོགས་ཆེན་")
    assert_equal "smon lam", Tibetan.t("སྨོན་ལམ་")
    
    assert_equal "dpal ", Tibetan.t("དཔལ་")
    assert_equal "sgra ", Tibetan.t("སྒྲ་")
    assert_equal "dbyangs ", Tibetan.t("དབྱངས་")
    assert_equal "go la spyi'i rin thang /", Tibetan.t("གོ་ལ་སྤྱིའི་རིན་ཐང་།")

    # FIXME:
    # assert_equal "ma'i", Tibetan.t("མའི་")
    # assert_equal "nang chos dang kha che'i chos lugs/_tshad mtho/", Tibetan.t("ནང་ཆོས་དང་ཁ་ཆེའི་ཆོས་ལུགས། ཚད་མཐོ།")
    # assert_equal "dge slong ma'i tshogs 'du'i gsung bshad phyoDa bsdoms/_nyin 1/", Tibetan.t("དགེ་སློང་མའི་ཚོགས་འདུའི་གསུང་བཤད་ཕྱོཌ་བསྡོམས། ཉིན་༡།")

    # Exceptions
    # assert_equal "g.yas", Tibetan.t("གཡས་")
    # assert_equal "g.yon", Tibetan.t("གཡོན་")    
  end
  
  def test_it_transliterates_punctuation
    assert_equal "_", Tibetan.t(" ")
    # 1. the syllabic boundary marker is represented by a hyphen in proper names and by a space in other words
    assert_equal " ", Tibetan.t("་")
    # 2. Transcribe a centered point ( ・) indicating a space with a space.
    # assert_equal " ", Tibetan.t("・")
    # assert_equal "ʼBaʼ Bsod-bhas brtsams", Tibetan.t("འབའ・བསྡྷོད་བྷས་བརྩམས།")
    # 3. Transcribe angle brackets (guillemets) (《 ... 》) used in the manner of quotation marks (“ ... ”) as quotation marks.
    # Angle brackets are most typically used for indicating the titles of works.
  end

  def test_it_transliterates_numbers
    assert_equal "0 1 2 3 4 5 6 7 8 9", Tibetan.t("༠་༡་༢་༣་༤་༥་༦་༧་༨་༩")
  end
  
  def test_it_transliterates_half_numbers
    assert_equal "0.5 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5", Tibetan.t("༪་༫་༬་༭་༮་༯་༰་༱་༲་༳")
  end
end

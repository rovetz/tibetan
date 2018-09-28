require "test_helper"

class TibetanTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tibetan::VERSION
  end

  def test_it_transliterates_tibetan
    assert_equal "bod skd ", Tibetan.t("བོད་སྐད་")
    # assert_equal "shuddho`haṃ", Tibetan.t("ཤུདྡྷོ྅ཧ")
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

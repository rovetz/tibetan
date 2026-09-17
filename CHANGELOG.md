# Changelog

## Unreleased

## Version 0.2.0 (2026-09-17)

* **Performance:**
  * ~15.4x transliteration speedup via precompiled regular expressions and Set-based character lookup.
  * Eliminated redundant array allocations and `string.chars` calls during root consonant detection.
* **Extended Wylie (EWTS) & Sanskrit Support:**
  * Added Sanskrit aspirated consonants (`གྷ`, `ཌྷ`, `དྷ`, `བྷ`, `ཛྷ`) and their subjoined forms (`ྒྷ`, `ྜྷ`, `ྡྷ`, `ྦྷ`, `ྫྷ`, `ྐྵ`).
  * Added Sanskrit signs: avagraha `྅` (`` ` ``), anusvara `ཾ` (`ṃ`), candrabindu `ྃ` (`~ṃ`), and visarga `ཿ` (`ḥ`).
  * Added punctuation support for centered point `・` (space) and angle brackets `《 ... 》` (`"..."`).
  * Fixed errant tab character in character mapping for U+0F07 (`"༇"`).
* **CLI Executable:**
  * Added `exe/tibetan` command-line tool supporting arguments, file reading, and piped STDIN input (`-v`, `--help`).
* **Documentation & Developer Experience:**
  * Added comprehensive YARD documentation for all public APIs (`Tibetan.transliterate`, `Tibetan.t`).
  * Updated README with CLI instructions and EWTS Sanskrit transliteration examples.
* **Testing:**
  * Added extensive real-world integration test suite with 500 Tibetan terms from the UMA (University of Virginia) glossaries fixture.
  * Added integration tests for the CLI executable covering arguments, pipes, and version display.
* **Architecture & Encapsulation:**
  * Encapsulated internal helper `insert_default_vowel!` as a private class method.
  * Added defensive edge case handling for `nil`, empty strings, and mixed non-Tibetan text.
* **Infrastructure & Tooling:**
  * Replaced deprecated Travis CI with GitHub Actions matrix (Ruby 3.1 - head).
  * Modernized gemspec (`required_ruby_version >= 3.0.0`, metadata URIs, resilient packaging).
  * Added RuboCop with custom configuration integrated into default `rake` task.
  * Updated default branch references from `master` to `main`.
  * Added Dependabot configuration for GitHub Actions automated updates.
  * Pinned Ruby version in `.ruby-version`.

## Version 0.1.5

* Improve transliteration accuracy and add more tests.
* Add rule to insert implicit vowel 'a' before 'a-chung (`འ`) preceded by consonant/subscript.
* Distinguish prefix `g` and root `y` (`g.y`) from root `g` and subjoined `y` (`gy`).
* Clean up erroneous spaces before closing brackets and punctuation.

## Version 0.1.4

* Fix string mutation warnings on modern Ruby versions.
* Update development dependencies: `bundler`, `rake`, `minitest`.

## Version 0.1.3

* Add comprehensive references on Tibetan transliteration.

## Version 0.1.2

* Insert default vowel "a".
* Split long phrases into smaller parts and transliterate separately.
* Expand test coverage.

## Version 0.1.1

* Convert spaces to underscores.
* Update test suite.

## Version 0.1.0

* Initial release.

# jQuery Auto Kana Input (jquery-auto-kana-input)

In forms of Japanese websites, we fill in the annoying kana (hiragana/katakana) fields.
The JQuery plugin helps to insert those fields.

## About jQuery Auto Kana Input

The jQuery plugin observes kanji \<input\> fields input with IME. If someone type keys and fill kanjis, the plugin will insert corresponding kana into other kana fields.

## Usage

This code

    $(function () {
      $('input#name').auto_kana_input();
    });

will observes the value of \<input id="name"\>. If you fill kanjis the field, corresponding kanas will automatically be inserted into \<input id="name_kana"\>.

## License

jQuery Auto Kana Input is released under the MIT license:

* see {LICENSE}[link:/ysawa/jquery-auto-kana-input/blob/master/LICENSE.txt].

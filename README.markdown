# jQuery Auto Kana Input (jquery-auto-kana-input)

In forms of Japanese websites, we fill in the annoying kana (hiragana/katakana) fields.
The JQuery plugin helps to insert those fields.

## About jQuery Auto Kana Input

The jQuery plugin observes kanji \<input\> fields input with IME. If someone type keys and fill kanjis, the plugin will insert corresponding kana into other kana fields.

## Usage

First, you should load the scripts of jquery and jquery-auto-kana-input. Next, This code

    $(function () {
      $('input#name').auto_kana_input();
    });

will observes the value of \<input id="name"\>. If you fill kanjis the field, corresponding kanas will automatically be inserted into \<input id="name_kana"\>.

## Compatibility

I checked the plugin around Google Chrome v19.0.1084.46 and Safari v5.1.7 (7534.57.2) on Mac OS X (Lion). I used Kotoeri and ATOK 2011 for Mac Ver.24.0.2 as IME. In those environments, it works and I have had good feelings with it. However, unfortunately the plugin did not work.

Therefore, on

* Google Chrome
* Safari

the plugin may work.

## License

jQuery Auto Kana Input is released under the MIT license:

* see [LICENSE](/ysawa/jquery-auto-kana-input/blob/master/LICENSE.txt).

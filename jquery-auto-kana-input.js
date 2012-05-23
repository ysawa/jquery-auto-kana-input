(function() {

  $.fn.extend({
    auto_kana_input: function(options) {
      var ALPHABET_REGEXP, KANA_REGEXP, kana_field_selector, kanji_field_selector, last_kanji_character, past_kanji, past_length_point;
      if (options == null) options = {};
      ALPHABET_REGEXP = /^[a-zA-Z]$/;
      KANA_REGEXP = /^[ぁ-んァ-ヶー]$/;
      past_kanji = null;
      past_length_point = 0;
      last_kanji_character = null;
      kanji_field_selector = this.selector;
      kana_field_selector = options.target || (kanji_field_selector + '_kana');
      return this.live('keydown', function(event) {
        var append_character_to_kana_field, calculate_length_point, clear_kana_field, is_kana, is_special_key, kanji, kanji_character, length, length_point, one_more_kanji_character, replace_to_katakana, select_kana_field;
        append_character_to_kana_field = function(character) {
          var kana_field, val;
          kana_field = select_kana_field();
          val = kana_field.val();
          return kana_field.val(val + replace_to_katakana(character));
        };
        is_special_key = function(event) {
          var special_keys;
          special_keys = [8, 13, 32, 37, 38, 39, 40];
          return $.inArray(event.which, special_keys) !== -1;
        };
        is_kana = function(character) {
          return character.match(KANA_REGEXP);
        };
        clear_kana_field = function() {
          return select_kana_field().val('');
        };
        select_kana_field = function() {
          return $(kana_field_selector);
        };
        calculate_length_point = function(kanji) {
          var character, i, point, _ref;
          point = 0;
          for (i = 0, _ref = kanji.length - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
            character = kanji.charAt(i);
            if (character.match(ALPHABET_REGEXP)) {
              point += 1;
            } else {
              point += 3;
            }
          }
          return point;
        };
        replace_to_katakana = function(hiragana) {
          return hiragana.replace(/[\u3041-\u3093]/g, function(character) {
            return String.fromCharCode(character.charCodeAt(0) + 0x60);
          });
        };
        kanji = $(this).val();
        length = kanji.length;
        length_point = calculate_length_point(kanji);
        kanji_character = kanji.charAt(length - 1);
        if (length_point > past_length_point && is_kana(kanji_character) && !is_special_key(event)) {
          one_more_kanji_character = kanji.charAt(length - 2);
          if (length_point - past_length_point > 3 && is_kana(one_more_kanji_character)) {
            append_character_to_kana_field(one_more_kanji_character);
          } else if (one_more_kanji_character.match(/^[っッ]$/)) {
            append_character_to_kana_field(one_more_kanji_character);
          }
          append_character_to_kana_field(kanji_character);
        }
        if (length === 0) {
          clear_kana_field();
          length_point = 0;
        }
        past_kanji = kanji;
        past_length_point = length_point;
        return last_kanji_character = kanji_character;
      });
    }
  });

}).call(this);

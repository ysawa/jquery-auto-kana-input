(function() {
  $.fn.extend({
    auto_kana_input: function(options) {
      var kana_field_selector, kanji_field_selector, last_kanji_character, past_kanji, past_length;
      if (options == null) {
        options = {};
      }
      past_kanji = null;
      last_kanji_character = null;
      kanji_field_selector = this.selector;
      kana_field_selector = options.target || (kanji_field_selector + '_kana');
      past_length = 0;
      return this.live('keydown', function(event) {
        var append_character_to_kana_field, clear_kana_field, is_kana, kanji, kanji_character, length, replace_to_katakana, select_kana_field;
        append_character_to_kana_field = function(character) {
          var kana_field, val;
          kana_field = select_kana_field();
          val = kana_field.val();
          return kana_field.val(val + replace_to_katakana(character));
        };
        is_kana = function(character) {
          return character.match(/^[ぁ-んァ-ヶー]$/);
        };
        clear_kana_field = function() {
          return select_kana_field().val('');
        };
        select_kana_field = function() {
          return $(kana_field_selector);
        };
        replace_to_katakana = function(hiragana) {
          return hiragana.replace(/[\u3041-\u3093]/g, function(character) {
            return String.fromCharCode(character.charCodeAt(0) + 0x60);
          });
        };
        kanji = $(this).val();
        length = kanji.length;
        kanji_character = kanji.charAt(length - 1);
        if (past_kanji !== kanji && is_kana(kanji_character) && event.which !== 8) {
          append_character_to_kana_field(kanji_character);
        }
        if (kanji.length === 0) {
          clear_kana_field();
        }
        past_kanji = kanji;
        last_kanji_character = kanji_character;
        return past_length = length;
      });
    }
  });
}).call(this);

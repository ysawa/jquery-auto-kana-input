$.fn.extend
  auto_kana_input: (options = {}) ->
    ALPHABET_REGEXP = /^[a-zA-Z]$/
    KANA_REGEXP = /^[ぁ-んァ-ヶー]$/
    past_kanji = null
    past_length_point = 0
    last_kanji_character = null
    kanji_field_selector = this.selector
    kana_field_selector = options.target || (kanji_field_selector + '_kana')
    this.live 'keydown', (event) ->
      append_character_to_kana_field = (character) ->
        kana_field = select_kana_field()
        val = kana_field.val()
        kana_field.val(val + replace_to_katakana(character))

      is_special_key = (event) ->
        special_keys = [8, 13, 32, 37, 38, 39, 40] # backscape, enter, spacebar, left, up, right, down
        $.inArray(event.which, special_keys) != -1

      is_kana = (character) ->
        character.match(KANA_REGEXP)

      clear_kana_field = () ->
        select_kana_field().val('')

      select_kana_field = () ->
        $(kana_field_selector)

      calculate_length_point = (kanji) ->
        point = 0
        for i in [0..(kanji.length - 1)]
          character = kanji.charAt(i)
          if character.match(ALPHABET_REGEXP)
            point += 1
          else
            point += 3
        point

      replace_to_katakana = (hiragana) ->
        hiragana.replace(/[\u3041-\u3093]/g, (character) ->
          String.fromCharCode(character.charCodeAt(0) + 0x60)
        )

      kanji = $(this).val()
      length = kanji.length
      length_point = calculate_length_point(kanji)
      kanji_character = kanji.charAt(length - 1)

      if length_point > past_length_point and is_kana(kanji_character) and !is_special_key(event)
        one_more_kanji_character = kanji.charAt(length - 2)
        if length_point - past_length_point > 3 and is_kana(one_more_kanji_character)
          append_character_to_kana_field(one_more_kanji_character)
        else if one_more_kanji_character.match(/^[っッ]$/)
          append_character_to_kana_field(one_more_kanji_character)
        append_character_to_kana_field(kanji_character)
      if length == 0
        clear_kana_field()
        length_point = 0
      past_kanji = kanji
      past_length_point = length_point
      last_kanji_character = kanji_character

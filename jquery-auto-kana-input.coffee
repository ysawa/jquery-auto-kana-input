$.fn.extend
  auto_kana_input: (options = {}) ->
    past_kanji = null
    last_kanji_character = null
    kanji_field_selector = this.selector
    kana_field_selector = options.target || (kanji_field_selector + '_kana')
    this.live 'keyup', (event) ->
      append_character_to_kana_field = (character) ->
        kana_field = select_kana_field()
        val = kana_field.val()
        kana_field.val(val + replace_to_katakana(character))

      is_backspace = (event) ->
        event.which != 8

      is_kana = (character) ->
        character.match(/^[ぁ-んァ-ヶー]$/)

      clear_kana_field = () ->
        select_kana_field().val('')

      select_kana_field = () ->
        $(kana_field_selector)

      replace_to_katakana = (hiragana) ->
        hiragana.replace(/[\u3041-\u3093]/g, (character) ->
          String.fromCharCode(character.charCodeAt(0) + 0x60)
        )

      kanji = $(this).val()
      length = kanji.length
      kanji_character = kanji.charAt(length - 1)

      if past_kanji != kanji and is_kana(kanji_character) and is_backspace(event)
        append_character_to_kana_field(kanji_character)
      if length == 0
        clear_kana_field()
      past_kanji = kanji
      last_kanji_character = kanji_character

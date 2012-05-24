$.fn.extend
  auto_kana_input: (options = {}) ->
    ALPHABET_REGEXP = /^[a-zA-Z]$/
    KANA_REGEXP = /^[ぁ-んァ-ヶー]$/
    rome_buffer = ''
    kanji_field_selector = this.selector
    kanji_field = $(kanji_field_selector)
    kana_field_selector = options.target || (kanji_field_selector + '_kana')
    kana_field = $(kana_field_selector)
    katakana = options.katakana

    is_special_key = (keycode) ->
      special_keys = [8, 13, 32, 37, 38, 39, 40, 229] # backscape, enter, spacebar, left, up, right, down
      $.inArray(keycode, special_keys) != -1

    is_rome_key = (keycode) ->
      (keycode >= 65) and (keycode <= 90)

    append_character_to_kana_field = (character) ->
      value = kana_field.val()
      if katakana
        value = value + replace_to_katakana(character)
      else
        value = value + character
      kana_field.val(value)

    clear_kana_field = () ->
      kana_field.val('')

    replace_to_katakana = (hiragana) ->
      hiragana.replace(/[\u3041-\u3093]/g, (character) ->
        String.fromCharCode(character.charCodeAt(0) + 0x60)
      )

    append_rome_buffer = (rome) ->
      rome_buffer += rome

    clear_rome_buffer = () ->
      rome_buffer = ''

    pop_rome_buffer = () ->
      if rome_buffer.match(/^nn$/)
        kana = 'ん'
        clear_rome_buffer()
        return kana
      if rome_buffer.match(/^n[^aiueoy]$/)
        kana = 'ん'
        rome_buffer = rome_buffer.substring(1)
        return kana
      if rome_buffer.match(/^(bb|cc|dd|ff|gg|hh|jj|kk|ll|mm|pp|qq|rr|ss|tt|vv|ww|xx|yy|zz)$/)
        kana = 'っ'
        rome_buffer = rome_buffer.substring(1)
        return kana
      kana = $.auto_kana_rome_table[rome_buffer]
      if kana
        clear_rome_buffer()
        kana
      else
        false

    safe_sweep_rome_buffer = () ->
      if rome_buffer.length >= 4
        rome_buffer = rome_buffer.substring(1)

    this.live 'keyup', (event) ->
      keycode = event.which

      if is_rome_key(keycode)
        rome = String.fromCharCode(keycode).toLowerCase()
        append_rome_buffer(rome)
        safe_sweep_rome_buffer()
        kana = pop_rome_buffer()
        if kana
          append_character_to_kana_field(kana)
      else if keycode == 189
        if rome_buffer.substring(0, 1) == 'n'
          append_character_to_kana_field('ん')
        append_character_to_kana_field('ー')
        clear_rome_buffer()

      if kanji_field.val() == ''
        clear_kana_field()

$.extend
  auto_kana_rome_table:
    a: 'あ'
    i: 'い'
    u: 'う'
    e: 'え'
    o: 'お'
    ka: 'か'
    ki: 'き'
    ku: 'く'
    ke: 'け'
    ko: 'こ'
    sa: 'さ'
    si: 'し'
    su: 'す'
    se: 'せ'
    so: 'そ'
    ta: 'た'
    ti: 'ち'
    tu: 'つ'
    te: 'て'
    to: 'と'
    na: 'な'
    ni: 'に'
    nu: 'ぬ'
    ne: 'ね'
    no: 'の'
    ha: 'は'
    hi: 'ひ'
    hu: 'ふ'
    he: 'へ'
    ho: 'ほ'
    ma: 'ま'
    mi: 'み'
    mu: 'む'
    me: 'め'
    mo: 'も'
    ya: 'や'
    yi: 'い'
    yu: 'ゆ'
    ye: 'いぇ'
    yo: 'よ'
    ra: 'ら'
    ri: 'り'
    ru: 'る'
    re: 'れ'
    ro: 'ろ'
    wa: 'わ'
    wi: 'うぃ'
    wu: 'う'
    we: 'うぇ'
    wo: 'を'
    nn: 'ん'
    ga: 'が'
    gi: 'ぎ'
    gu: 'ぐ'
    ge: 'げ'
    go: 'ご'
    za: 'ざ'
    zi: 'じ'
    zu: 'ず'
    ze: 'ぜ'
    zo: 'ぞ'
    ja: 'じゃ'
    ji: 'じ'
    ju: 'じゅ'
    je: 'じぇ'
    jo: 'じょ'
    da: 'だ'
    di: 'ぢ'
    du: 'づ'
    de: 'で'
    do: 'ど'
    ba: 'ば'
    bi: 'び'
    bu: 'ぶ'
    be: 'べ'
    bo: 'ぼ'
    pa: 'ぱ'
    pi: 'ぴ'
    pu: 'ぷ'
    pe: 'ぺ'
    po: 'ぽ'
    fa: 'ふぁ'
    fi: 'ふぃ'
    fu: 'ふ'
    fe: 'ふぇ'
    fo: 'ふぉ'
    kya: 'きゃ'
    kyi: 'きぃ'
    kyu: 'きゅ'
    kye: 'きぇ'
    kyo: 'きょ'
    sya: 'しゃ'
    syi: 'し'
    syu: 'しゅ'
    sye: 'しぇ'
    syo: 'しょ'
    sha: 'しゃ'
    shi: 'し'
    shu: 'しゅ'
    she: 'しぇ'
    sho: 'しょ'
    tya: 'ちゃ'
    tyi: 'ちぃ'
    tyu: 'ちゅ'
    tye: 'ちぇ'
    tyo: 'ちょ'
    tha: 'てゃ'
    thi: 'てぃ'
    thu: 'てゅ'
    the: 'てぇ'
    tho: 'てょ'
    nya: 'にゃ'
    nyi: 'にぃ'
    nyu: 'にゅ'
    nye: 'にぇ'
    nyo: 'にょ'
    hya: 'ひゃ'
    hyi: 'ひぃ'
    hyu: 'ひゅ'
    hye: 'ひぇ'
    hyo: 'ひょ'
    mya: 'みゃ'
    myi: 'みぃ'
    myu: 'みゅ'
    mye: 'みぇ'
    myo: 'みょ'
    gya: 'ぎゃ'
    gyi: 'ぎぃ'
    gyu: 'ぎゅ'
    gye: 'ぎぇ'
    gyo: 'ぎょ'
    zya: 'じゃ'
    zyi: 'じぃ'
    zyu: 'じゅ'
    zye: 'じぇ'
    zyo: 'じょ'
    jya: 'じゃ'
    jyi: 'じぃ'
    jyu: 'じゅ'
    jye: 'じぇ'
    jyo: 'じょ'
    dya: 'ぢゃ'
    dyi: 'ぢぃ'
    dyu: 'ぢゅ'
    dye: 'ぢぇ'
    dyo: 'ぢょ'
    dha: 'でゃ'
    dhi: 'でぃ'
    dhu: 'でゅ'
    dhe: 'でぇ'
    dho: 'でょ'
    bya: 'びゃ'
    byi: 'びぃ'
    byu: 'びゅ'
    bye: 'びぇ'
    byo: 'びょ'
    pya: 'ぴゃ'
    pyi: 'ぴぃ'
    pyu: 'ぴゅ'
    pye: 'ぴぇ'
    pyo: 'ぴょ'
    rya: 'りゃ'
    ryi: 'りぃ'
    ryu: 'りゅ'
    rye: 'りぇ'
    ryo: 'りょ'
    xa: 'ぁ'
    xi: 'ぃ'
    xu: 'ぅ'
    xe: 'ぇ'
    xo: 'ぉ'
    la: 'ぁ'
    li: 'ぃ'
    lu: 'ぅ'
    le: 'ぇ'
    lo: 'ぉ'


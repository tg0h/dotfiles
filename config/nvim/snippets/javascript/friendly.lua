return {
  s(
    'cl',
    fmt(
      [[console.log({}{})
{}
]],
      {
        c(1, { sn(nil, { t("'"), i(1, ''), t("'") }), i(nil, '') }),
        c(2, { sn(nil, { t(','), i(1, '') }), i(nil, '') }),
        i(0, ''),
      }
    )
  ),
  s('c', fmt([[const {} = {}]], { i(1), i(0) })),
  s('l', { t('let '), i(1, '') }),
  s('js', fmt([[JSON.stringify({}){}]], { i(1), i(0) })),
  s(
    'ifs',
    fmt(
      [[import fs from 'fs'
{}
]],
      { i(nil, '') }
    )
  ),
}, {
  -- s('autotrig', t('autotriggered, if enabled')),
}

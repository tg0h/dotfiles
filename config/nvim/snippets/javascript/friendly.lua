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
  s('ao', fmt([[console.log({})]], { i(1, '') })),
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
  s('ihcs', { t("import { createServer } from 'http'") }),
  s('icc', { t("import cluster from 'cluster'") }),
  s('ioc', { t("import { cpus } from 'os'") }),
  s('icpf', { t("import { fork } from 'child_process'") }),
  s('ihh', { t("import http from 'http'") }),
  s('iuf', { t("import { fileURLToPath } from 'url'") }),
  s('do', {
    t('/*'),
    sn(nil, { t('*'), i(1, '') }),
    t('*/'),
  }),
}, {
  -- s('autotrig', t('autotriggered, if enabled')),
}

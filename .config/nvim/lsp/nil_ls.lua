return {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  settings = {
    prisma = {
      prismaFmtBinPath = '',
    },
  },
  root_markers = { 'yarn.lock', 'lerna.json', 'package.json' },
}

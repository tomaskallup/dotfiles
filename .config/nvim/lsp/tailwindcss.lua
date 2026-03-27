return {
	cmd = { 'tailwindcss-language-server', '--stdio' },
	filetypes = {
		'eelixir',
		'elixir',
		'html',
		'html-eex',
		'heex',
		'css',
		'less',
		'postcss',
		'sass',
		'scss',
		'stylus',
		'javascriptreact',
		'typescript',
		'typescriptreact',
	},
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        elixir = 'phoenix-heex',
        heex = 'phoenix-heex',
      },
    },
  },
}

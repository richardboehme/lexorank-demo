const esbuild = require('esbuild')
const { stimulusPlugin } = require('esbuild-plugin-stimulus')
const { copy } = require('esbuild-plugin-copy')
const { clean } = require('esbuild-plugin-clean')


esbuild.build({
  plugins: [
    stimulusPlugin(),
    copy({
      resolveFrom: 'cwd',
      assets: {
        from: [
          './node_modules/bootstrap-icons/icons/list.svg',
          './node_modules/bootstrap-icons/icons/code-slash.svg',
          './node_modules/bootstrap-icons/icons/github.svg',
          './node_modules/bootstrap-icons/icons/exclamation-triangle.svg',
          './node_modules/bootstrap-icons/icons/check.svg',
          './node_modules/bootstrap-icons/icons/trash.svg',
          './node_modules/bootstrap-icons/icons/arrow-up.svg',
          './node_modules/bootstrap-icons/icons/arrow-down.svg',
          './node_modules/bootstrap-icons/icons/sort-alpha-down.svg',
          './node_modules/bootstrap-icons/icons/plus.svg'
        ],
        to: ['./app/assets/builds/static/*'],
      },
    }),
    clean({
      patterns: ['./app/assets/builds/*', './app/assets/builds/static/*']
    })
  ],
  entryPoints: ['app/assets/entrypoints/application.js'],
  bundle: true,
  outdir: 'app/assets/builds',
  sourcemap: true,
  watch: process.env.WATCH == 'true' ? {
    onRebuild(error, result) {
      if (error) console.error('watch build failed:', error)
      else console.log('watch build succeeded')
    },
  } : false
}).catch(() => process.exit(1))

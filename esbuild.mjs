import * as esbuild from 'esbuild'
import { stimulusPlugin } from 'esbuild-plugin-stimulus'
import { copy } from 'esbuild-plugin-copy'
import { clean } from 'esbuild-plugin-clean'


const ctx = await esbuild.context({
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
        to: ['./app/assets/builds/static'],
      },
    }),
    clean({
      patterns: ['./app/assets/builds/*', './app/assets/builds/static/*', '!./app/assets/builds/*.css']
    })
  ],
  entryPoints: ['app/assets/entrypoints/application.js'],
  bundle: true,
  outdir: 'app/assets/builds',
  sourcemap: true,
  logLevel: 'info'
})

if(process.env.WATCH === 'true') {
  await ctx.watch()
} else {
  await ctx.rebuild()
  await ctx.dispose()
}

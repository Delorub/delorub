// Note: You must restart bin/webpack-dev-server for changes to take effect

/* eslint global-require: 0 */

const RollbarSourceMapPlugin = require('rollbar-sourcemap-webpack-plugin')
const webpack = require('webpack')
const merge = require('webpack-merge')
const CompressionPlugin = require('compression-webpack-plugin')
const sharedConfig = require('./shared.js')
const { gitVersion, rollbarServerAccessToken } = require('./configuration.js')

module.exports = merge(sharedConfig, {
  output: { filename: '[name]-[chunkhash].js' },
  devtool: 'source-map',
  stats: 'normal',

  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      minimize: true,
      sourceMap: true,

      compress: {
        warnings: false
      },

      output: {
        comments: false
      }
    }),
    new CompressionPlugin({
      asset: '[path].gz[query]',
      algorithm: 'gzip',
      test: /\.(js|css|html|json|ico|svg|eot|otf|ttf)$/
    }),
    new RollbarSourceMapPlugin({
      accessToken: rollbarServerAccessToken,
      version: gitVersion,
      publicPath: 'http://delorub.ru/packs'
    })
  ]
})

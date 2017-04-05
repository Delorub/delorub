/* eslint comma-dangle: ["error",
  {"functions": "never", "arrays": "only-multiline", "objects": "only-multiline"} ] */

const webpack = require('webpack');
const path = require('path');
const autoprefixer = require('autoprefixer');
const copyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';
const sourcePath = path.join(__dirname, './app');

module.exports = {
  context: __dirname,
  entry: {
    vendor: [
      'babel-polyfill',
      'es5-shim/es5-shim',
      'es5-shim/es5-sham'
    ],

    contract_designer_app: [
      './app/bundles/ContractDesignerApp/startup/clientRegistration',
    ],

    contract_app: [
      './app/bundles/ContractApp/startup/clientRegistration',
    ],

    website: [
      './app',
      `bootstrap-loader/lib/bootstrap.loader?configFilePath=${__dirname}/bootstrap.yml!bootstrap-loader/no-op.js`,
    ],
  },
  output: {
    filename: '[name]-bundle.js',
    path: path.resolve(__dirname, '../app/assets/webpack'),
  },
  resolve: {
    extensions: ['.webpack-loader.js', '.web-loader.js', '.loader.js', '.js', '.jsx'],
    modules: [
      'node_modules', 'web_modules'
    ],
    alias: {
      libs: path.join(process.cwd(), 'app', 'libs'),
      react: path.resolve('./node_modules/react'),
    },
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(nodeEnv),
      },
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor',
      filename: 'vendor-bundle.js',
      minChunks: Infinity,
      chunks: ['vendor', 'contract_designer_app', 'contract_app']
    }),
    new copyWebpackPlugin([
      { from: './node_modules/tinymce/skins', to: './skins' },
      { from: './node_modules/tinymce/plugins', to: './plugins' },
      { from: './app/libs/tinymce', to: '.' },
    ]),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      "window.jQuery": "jquery"
    }),
    new ExtractTextPlugin({
      filename: '[name]-bundle.css',
      allChunks: true,
      disable: false
    })
  ],
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      { test: /\.json$/, use: 'json-loader' },
      { test: /\.(woff2?|svg)$/, use: 'url-loader?limit=10000' },
      { test: /\.(ttf|eot|otf)$/, use: 'file-loader' },
      {
        test: require.resolve('tinymce/tinymce'),
        use: [
          'imports-loader?this=>window',
          'exports-loader?window.tinymce'
        ]
      },
      {
        test: /tinymce\/(themes|plugins)\//,
        use: [
          'imports-loader?this=>window'
        ]
      },
      { test: /bootstrap-sass\/assets\/javascripts\//, use: 'imports-loader?jQuery=jquery' },
      {
        test: /\.(jpg|jpeg|png)(\?.*)?$/,
        use: {
          loader: 'file-loader',
          options: {
            name: '[name][md5:hash].[ext]',
            outputPath: 'webpack-assets/',
            publicPath: '/assets/webpack-assets/'
          }
        }
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        use: {
          loader: 'file-loader',
          query: {
            name: '[name].[ext]'
          },
        },
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader?minimize'
        })
      },
      {
        test: /(\.scss|\.sass)$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: 'css-loader?minimize!sass-loader'
        })
      },
      {
        test: require.resolve('react'),
        use: 'imports-loader?shim=es5-shim/es5-shim&sham=es5-shim/es5-sham',
      }
    ],
  },
  //devtool: devBuild ? 'eval-source-map' : 'source-map',
  devServer: {
    contentBase: [
      path.join(__dirname, 'markup'),
      path.join(__dirname, '../public')
    ],
    port: 9000,
    stats: {
      assets: true,
      children: false,
      chunks: false,
      hash: false,
      modules: false,
      publicPath: false,
      timings: true,
      version: false,
      warnings: true,
      colors: {
        green: '\u001b[32m',
      }
    },
  }

  //postcss: [autoprefixer],
};

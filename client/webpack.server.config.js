/* eslint comma-dangle: ["error",
  {"functions": "never", "arrays": "only-multiline", "objects": "only-multiline"} ] */

// Common webpack configuration for server bundle

const webpack = require('webpack');
const ManifestPlugin = require('webpack-manifest-plugin');
const { resolve } = require('path');
const webpackConfigLoader = require('react-on-rails/webpackConfigLoader');
const configPath = resolve('..', 'config');
const { manifest } = webpackConfigLoader(configPath);
const { webpackOutputPath, webpackPublicOutputDir } = webpackConfigLoader(configPath);
const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

module.exports = {
  context: __dirname,
  entry: [
    'babel-polyfill',
    './app/bundles/ContractApp/startup/clientRegistration',
    './app/bundles/NotificationsApp/startup/clientRegistration',
    './app/bundles/CreateProfileApp/startup/clientRegistration',
    './app/bundles/TaskFormApp/startup/clientRegistration',
  ],
  output: {
    filename: 'server.js',
    path: webpackOutputPath
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      libs: resolve(process.cwd(), 'app', 'libs'),
    },
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(nodeEnv),
      },
    }),
  ],
  module: {
    loaders: [
      { test: /\.json$/, use: 'json-loader' },
      { test: /\.jsx?$/, use: 'babel-loader', exclude: /node_modules/ },
      {
        test: /\.css$/,
        use: [
          'css-loader/locals?modules&importLoaders=0&localIdentName=[name]__[local]__[hash:base64:5]',
        ],
      },
      {
        test: /\.scss$/,
        use: [
          'css-loader/locals?modules&importLoaders=2&localIdentName=[name]__[local]__[hash:base64:5]',
          'sass-loader',
        ],
      },
    ],
  },

};

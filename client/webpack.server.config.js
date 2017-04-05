/* eslint comma-dangle: ["error",
  {"functions": "never", "arrays": "only-multiline", "objects": "only-multiline"} ] */

// Common webpack configuration for server bundle

const webpack = require('webpack');
const path = require('path');
const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

module.exports = {
  context: __dirname,
  entry: [
    'babel-polyfill',
    './app/bundles/ContractApp/startup/clientRegistration',
  ],
  output: {
    filename: 'server-bundle.js',
    path: path.resolve(__dirname, '../app/assets/webpack'),
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      libs: path.join(process.cwd(), 'app', 'libs'),
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

module.exports = {
  enforce: 'pre',
  test: /\.(js|jsx|vue)?(\.erb)?$/,
  exclude: /node_modules/,
  loader: 'eslint-loader'
}

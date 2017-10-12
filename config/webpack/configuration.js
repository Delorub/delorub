// Common configuration for webpacker loaded from config/webpacker.yml

const cp = require('child_process')
const { join, resolve } = require('path')
const { env } = require('process')
const { safeLoad } = require('js-yaml')
const { readFileSync } = require('fs')

const rollbarClientAccessToken = '83e53a8810ab4e639de400bd7e9350d8'
const rollbarServerAccessToken = 'b8c60cbe68e74d888ef43f3837df377f'

const configPath = resolve('config', 'webpacker.yml')
const loadersDir = join(__dirname, 'loaders')
const settings = safeLoad(readFileSync(configPath), 'utf8')[env.NODE_ENV]

function removeOuterSlashes (string) {
  return string.replace(/^\/*/, '').replace(/\/*$/, '')
}

function formatPublicPath (host = '', path = '') {
  let formattedHost = removeOuterSlashes(host)
  if (formattedHost && !/^http/i.test(formattedHost)) {
    formattedHost = `//${formattedHost}`
  }
  const formattedPath = removeOuterSlashes(path)
  return `${formattedHost}/${formattedPath}/`
}

const output = {
  path: resolve('public', settings.public_output_path),
  publicPath: formatPublicPath(env.ASSET_HOST, settings.public_output_path)
}

let gitVersion
try {
  gitVersion = cp.execSync('git rev-parse HEAD', {
    cwd: __dirname,
    encoding: 'utf8'
  })
} catch (err) {
  try {
    gitVersion = cp.execSync('cat ' + resolve('REVISION'), {
      cwd: __dirname,
      encoding: 'utf8'
    })
  } catch (err) {
    // eslint-disable-line no-console
    console.log('Error getting revision', err)
    process.exit(1)
  }
}

module.exports = {
  settings,
  env,
  loadersDir,
  output,
  gitVersion,
  rollbarClientAccessToken,
  rollbarServerAccessToken
}

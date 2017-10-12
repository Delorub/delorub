import RollbarConstructor from 'rollbar'

let rollbarConfig = {
  // eslint-disable-next-line no-undef
  accessToken: __ROLLBAR_ACCESS_TOKEN__,
  captureUncaught: true,
  payload: {
    environment: process.env.NODE_ENV,
    client: {
      javascript: {
        source_map_enabled: true,
        // eslint-disable-next-line no-undef
        code_version: __GIT_REVISION__,
        guess_uncaught_frames: true
      }
    }
  }
}

if (process.env.NODE_ENV === 'development') {
  rollbarConfig['captureUncaught'] = false
  rollbarConfig['payload']['client']['javascript']['source_map_enabled'] = false
  rollbarConfig['payload']['client']['javascript']['guess_uncaught_frames'] = false
}

console.log(rollbarConfig)

var Rollbar = new RollbarConstructor(rollbarConfig)

export default Rollbar

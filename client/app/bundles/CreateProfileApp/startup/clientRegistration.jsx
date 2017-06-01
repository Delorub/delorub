import ReactOnRails from 'react-on-rails';

import CreateProfileApp from '../containers/CreateProfileApp';
import createProfileStore from '../store/createProfileStore';

ReactOnRails.register({
  CreateProfileApp
});

ReactOnRails.registerStore({
  createProfileStore
});

import ReactOnRails from 'react-on-rails';

import CreateProfileApp from '../containers/CreateProfileApp';
import profileStore from '../store/profileStore';

ReactOnRails.register({
  CreateProfileApp
});

ReactOnRails.registerStore({
  profileStore
});

import ReactOnRails from 'react-on-rails';

import NotificationsApp from '../containers/NotificationsApp';
import notificationsStore from '../store/notificationsStore';

ReactOnRails.register({
  NotificationsApp
});

ReactOnRails.registerStore({
  notificationsStore
});

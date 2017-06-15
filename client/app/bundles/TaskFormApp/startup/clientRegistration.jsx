import ReactOnRails from 'react-on-rails';

import TaskFormApp from '../containers/TaskFormApp';
import taskStore from '../store/taskStore';

ReactOnRails.register({
  TaskFormApp
});

ReactOnRails.registerStore({
  taskStore
});

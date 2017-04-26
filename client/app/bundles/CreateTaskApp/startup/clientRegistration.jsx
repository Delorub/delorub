import ReactOnRails from 'react-on-rails';

import CreateTaskApp from '../containers/CreateTaskApp';
import taskStore from '../store/taskStore';

ReactOnRails.register({
  CreateTaskApp
});

ReactOnRails.registerStore({
  taskStore
});

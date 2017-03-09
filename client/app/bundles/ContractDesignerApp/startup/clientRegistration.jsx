import ReactOnRails from 'react-on-rails';

import ContractDesignerApp from '../containers/ContractDesignerApp';
import templateStore from '../store/templateStore';

ReactOnRails.register({
  ContractDesignerApp
});

ReactOnRails.registerStore({
  templateStore
});

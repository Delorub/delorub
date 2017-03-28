import ReactOnRails from 'react-on-rails';

import ContractApp from '../containers/ContractApp';
import contractStore from '../store/contractStore';
import ContractRenderApp from '../containers/ContractRenderApp';

ReactOnRails.register({
  ContractApp, ContractRenderApp
});

ReactOnRails.registerStore({
  contractStore
});

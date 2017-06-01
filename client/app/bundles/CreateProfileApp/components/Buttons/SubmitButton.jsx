import React from 'react';
import { connect } from 'react-redux';
import { submit } from 'redux-form';

const SubmitButton = ({ dispatch }) => (
  <input
    type="submit"
    onClick={() => dispatch(submit('create_profile'))}
    className="btn dr-button-blueFull"
    value="Далее"
  />
);

export default connect()(SubmitButton);

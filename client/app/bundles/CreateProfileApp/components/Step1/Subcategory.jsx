import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as profileActions from '../../actions/ProfileActions'
import { Field } from 'redux-form';

class Subcategory extends React.Component {
  render() {
    const { id, title, specializations } = this.props
    const selected = specializations.indexOf(id) > -1;
    const name = 'create_profile[specializations_ids][' + id + ']'

    return (
      <div className="checkbox">
        <label>
          <Field
            component="input"
            type="checkbox"
            name={name}
            value="1"
            />
            {title}
        </label>
      </div>
    );
  }
}

export default Subcategory

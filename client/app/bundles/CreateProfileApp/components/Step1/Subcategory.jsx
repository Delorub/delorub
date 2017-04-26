import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as profileActions from '../../actions/ProfileActions'

class Subcategory extends React.Component {
  handleChange(event) {
    this.props.toggleSubcategory(this.props.id)
  }

  render() {
    const { id, title, specializations } = this.props
    const selected = specializations.indexOf(id) > -1;

    return (
      <div className="checkbox">
        <label><input type="checkbox" value={id} checked={selected} onChange={::this.handleChange} />{title}</label>
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    specializations: state.$$profileStore.profile.specializations
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(profileActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Subcategory)

import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as profileActions from '../../actions/ProfileActions'

class Category extends React.Component {
  handleClick(event) {
    this.props.selectCategory(this.props.id)
  }

  render() {
    const { title } = this.props

    return (
      <div className="col-xs-6 col-sm-4 col-md-3 col-lg-2">
        <a href="#" className="dr-bottom-service-heading" onClick={::this.handleClick} >
          <img className="img-responsive" src="/images/icons/broom.png" alt="" />
          <span>{this.props.title}</span>
        </a>
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

export default connect(mapStateToProps, mapDispatchToProps)(Category)

import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as profileActions from '../../actions/ProfileActions'

class Category extends React.Component {
  handleClick(event) {
    event.preventDefault()
    this.props.change('create_profile[main_specialization_id]', this.props.id)
    if(this.props.main_specialization_id != this.props.id) {
      this.props.change('create_profile[specializations]', [])
    }
  }

  render() {
    const { title, photo_thumb_url } = this.props

    return (
      <div className="col-xs-6 col-sm-4 col-md-3 col-lg-2">
        <a href="#" className="dr-bottom-service-heading" onClick={::this.handleClick} >
          <img className="img-responsive" src={photo_thumb_url} alt="" />
          <span class="marked">{this.props.title}</span>
        </a>
      </div>
    );
  }
}

export default Category

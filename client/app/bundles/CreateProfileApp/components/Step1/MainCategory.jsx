import React from 'react';

export default class MainCategory extends React.Component {
  handleClick(event) {
    event.preventDefault()
    this.props.change('create_profile[main_category_id]', this.props.id)
    if(this.props.main_category_id != this.props.id) {
      this.props.change('create_profile[categories]', [])
    }
  }

  render() {
    const { title, photo_thumb_url } = this.props

    return (
      <div className="col-xs-6 col-sm-4 col-md-3 col-lg-2">
        <a href="#" className="dr-bottom-service-heading" onClick={::this.handleClick} >
          <img className="img-responsive" src={photo_thumb_url} alt="" />
          <span className="marked">{this.props.title}</span>
        </a>
      </div>
    );
  }
}
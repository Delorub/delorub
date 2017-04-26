import React from 'react';

export default class Category extends React.Component {
  render() {
    const { title } = this.props

    return (
      <div className="col-xs-6 col-sm-4 col-md-3 col-lg-2">
        <a href="#" className="dr-bottom-service-heading">
          <img className="img-responsive" src="/images/icons/broom.png" alt="" />
          <span>{this.props.title}</span>
        </a>
      </div>
    );
  }
}

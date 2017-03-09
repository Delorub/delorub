import React from 'react';

export default class VariantMarkup extends React.Component {
  render() {
    const { title, selection } = this.props

    return <p className="block" data-title={title}>{selection}</p>;
  }
}

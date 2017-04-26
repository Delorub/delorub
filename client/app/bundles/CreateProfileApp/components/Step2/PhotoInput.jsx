import React from 'react';

export default class PhotoInput extends React.Component {
  render() {
    return (
      <label className="dr-profile-avatar">
        <a href="#" className="dr-top-nav-icon icon-avtoriz"></a>
        <br />
        <span>Загрузить фото</span>
        <input type="file" />
      </label>
    );
  }
}

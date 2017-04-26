import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as profileActions from '../../actions/ProfileActions'

class PhotoInput extends React.Component {
  _handleImageChange(e) {
    var reader = new FileReader();
    var file = e.target.files[0];

    reader.onloadend = () => {
      this.props.setPhotoUrl(reader.result)
    }

    reader.readAsDataURL(file)
  }

  render() {
    const { photo_url } = this.props

    if (photo_url) {
      var imageStyle = {
        backgroundImage: 'url(' + photo_url + ')',
      }

      return (
        <label className="dr-profile-avatar" style={imageStyle}>
          <input type="file" onChange={::this._handleImageChange} />
        </label>
      );
    } else {
      return (
        <label className="dr-profile-avatar">
          <a href="#" className="dr-top-nav-icon icon-avtoriz"></a>
          <br />
          <span>Загрузить фото</span>
          <input type="file" onChange={::this._handleImageChange} />
        </label>
      );
    }


  }
}

function mapStateToProps(state) {
  return {
    photo_url: state.$$profileStore.profile.photo_url
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(profileActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(PhotoInput)

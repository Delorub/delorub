import React from 'react';
import Dropzone from 'react-dropzone';
import request from 'superagent';
import { Field } from 'redux-form';
import { required } from 'libs/delorub/redux-form-validations'

export default class PhotoInput extends React.Component {
  onUploadClick() {
    this.refs.dropzone.open()
  }

  onAddFiles(files) {
    request
      .post('/api/users/temporary_photo')
      .attach('photo', files[0])
      .end(::this.onUploadFinish)
  }

  onUploadFinish(error, result) {
    this.props.change('create_profile[photo_url]', result.body.upload_preview_url)
    this.props.change('create_profile[temporary_photo_id]', result.body.id)
  }

  renderFilePreview(params) {
    if(params.input.value) {
      return (
        <label className="dr-profile-uploaded-avatar" onClick={::this.onUploadClick}>
          <img src={params.input.value} />
        </label>
      )
    }

    return (
      <label className="dr-profile-avatar" onClick={::this.onUploadClick}>
        <a href="#" className="dr-top-nav-icon icon-avtoriz"></a>
        <br />
        <span>Загрузить фото</span>
      </label>
    )
  }

  renderErrors(params) {
    if(params.meta.touched && params.meta.error) {
      return (
        <p className="error">{params.meta.error}</p>
      )
    }

    return null;
  }

  renderFile(params) {
    return (
      <input type="hidden" name={params.input.name} value={params.input.value} />
    )
  }

  render() {
    return (
      <Dropzone
        ref="dropzone"
        disableClick
        name="temporary_photo"
        onDrop={( filesToUpload, e ) => this.onAddFiles(filesToUpload)}
        className="dr-task-photo dr-task-div center"
      >
        <span>Фото</span>
        <Field
          name="create_profile[temporary_photo_id]"
          component={::this.renderFile}
        />
        <Field
          name="create_profile[photo_url]"
          component={::this.renderFilePreview}
        />
        <span className="icon_top icon-information"></span>
        <p className="photoInfo">
          Максимальный размер файла 5 МБ,<br /> формат .jpg, .jpeg, .png, .gif.<br /> <b>Обратите внимание:</b> профили без фото не допускаются.
        </p>
        <Field
          name="create_profile[photo_url]"
          component={::this.renderErrors}
          validate={[required]}
        />
      </Dropzone>
    )
  }
}

import React from 'react';
import Dropzone from 'react-dropzone';
import request from 'superagent';
import { Field, FieldArray } from 'redux-form';

class PhotosInput extends React.Component {
  onUploadFinish(error, result) {
    console.log(this.props)
    this.props.array.push(this.props.fieldName, result.body)
  }

  onUploadClick() {
    this.refs.dropzone.open()
  }

  onAddFiles(files) {
    files.forEach(file => {
      request
        .post(this.props.apiUrl)
        .attach('file', file)
        .end(::this.onUploadFinish)
    });
  }

  renderFilePreview(params) {
    return (
      <div className="dr-task-photo-load-image">
        <img src={params.input.value} className="img-responsive" />
        <a><span className="glyphicon glyphicon-remove"></span></a>
      </div>
    )
  }

  renderFile(params) {
    return (
      <input type="hidden" name={this.props.inputName} value={params.input.value} />
    )
  }

  renderFiles(params) {
    return (
      <div className="dr-task-photo-load">
        {params.fields.map((field, index) =>
          <Field
            key={index}
            name={`${field}.${this.props.fieldId}`}
            component={::this.renderFile}
          />
        )}
        {params.fields.map((field, index) =>
          <Field
            key={index}
            name={`${field}.${this.props.fieldPreview}`}
            component={::this.renderFilePreview}
          />
        )}
      </div>
    )
  }

  render() {
    const { files } = this.props

    return (
      <div>
        <Dropzone
          ref="dropzone"
          disableClick
          onDrop={( filesToUpload, e ) => this.onAddFiles(filesToUpload)}
          className="dr-task-photo dr-task-div"
        >
          <div className="row">
            <div className="col-md-6">
              { this.props.label && (<span className="input-label">{this.props.label}<br /></span>) }
              <button type="button" className="btn dr-button-blue" onClick={::this.onUploadClick}>Выбрать фото</button>
            </div>
            <div className="col-md-6">
              <span className="icon_top icon-information"></span>
              <p className="marginTop10">Вы можете загрузить до 10 фото.</p>
              <p className="photoInfo">
                Максимальный размер файла 5 МБ, формат .jpg, .jpeg, .png, .gif.
              </p>
            </div>
          </div>
            <FieldArray name={this.props.fieldName} component={::this.renderFiles} />
        </Dropzone>
      </div>
    )
  }
}

export default PhotosInput

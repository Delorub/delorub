import React from 'react';
import Dropzone from 'react-dropzone';
import request from 'superagent';
import { Field, FieldArray } from 'redux-form';

class PhotoInput extends React.Component {
  onUploadFinish(error, result) {
    this.props.array.push('task[files]', result.body)
  }

  onUploadClick() {
    this.refs.dropzone.open()
  }

  onAddFiles(files) {
    files.forEach(file => {
      request
        .post('/api/uploads/task')
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
      <input type="hidden" name="task[files][][id]" value={params.input.value} />
    )
  }

  renderFiles(params) {
    return (
      <div className="dr-task-photo-load">
        {params.fields.map((field, index) =>
          <Field
            key={index}
            name={`${field}.id`}
            component={::this.renderFile}
          />
        )}
        {params.fields.map((field, index) =>
          <Field
            key={index}
            name={`${field}.upload_preview_url`}
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
          name={this.props.name}
          onDrop={( filesToUpload, e ) => this.onAddFiles(filesToUpload)}
          className="dr-task-photo dr-task-div"
        >
          <div className="row">
            <div className="col-md-6">
              <span className="input-label">Фото&nbsp;*</span>
              <br />
              <button type="button" className="btn dr-button-blue" onClick={::this.onUploadClick}>Выбрать фото</button>
            </div>
            <div className="col-md-6">
              <span className="icon_top icon-information"></span>
              <p className="photoInfo">
                Максимальный размер файла 5 МБ, формат .jpg, .jpeg, .png, .gif.
              </p>
            </div>
          </div>
            <FieldArray name="task[files]" component={::this.renderFiles} />
        </Dropzone>
      </div>
    )
  }
}

export default PhotoInput

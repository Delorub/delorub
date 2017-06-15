import React from 'react';
import { connect } from 'react-redux'
import Dropzone from 'react-dropzone';
import request from 'superagent';
import { Field, FieldArray } from 'redux-form';

class PhotoInput extends React.Component {
  onUploadFinish(error, result) {
    this.props.array.push('task[files]', result.body)
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
      <img src={params.input.value} className="img-responsive" width="108" />
    )
  }

  renderFile(params) {
    return (
      <input type="hidden" name="task[files][][id]" value={params.input.value} />
    )
  }

  renderFiles(params) {
    return (
      <div>
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
          name={this.props.name}
          onDrop={( filesToUpload, e ) => this.onAddFiles(filesToUpload)}
          className="dr-task-photo dr-task-div"
        >
          <div className="row">
            <div className="col-md-6">
              <span className="input-label">Фото&nbsp;*</span>
              <br />
              <button type="button" className="btn dr-button-blue">Выбрать фото</button>
            </div>
            <div className="col-md-6">
              <span className="icon_top icon-information"></span>
              <p className="photoInfo">
                Максимальный размер файла 5 МБ, формат .jpg, .jpeg, .png, .gif.
              </p>
            </div>
          </div>
        </Dropzone>
        <div className="dr-profile-gallery">
          <FieldArray name="task[files]" component={::this.renderFiles}/>
        </div>
      </div>
    )
  }
}

export default PhotoInput

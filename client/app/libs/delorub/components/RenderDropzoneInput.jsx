import React from 'react';
import Dropzone from 'react-dropzone';
import Photo from './Photo';

export default class RenderDropzoneInput extends React.Component {
  render() {
    const { input, options, data, meta, containerClasses, disabled, className, multiple, label } = this.props
    const files = input.value;

    return (
      <div>
        <Dropzone
          name={this.props.name}
          onDrop={( filesToUpload, e ) => input.onChange(filesToUpload)}
          className="dr-task-photo dr-task-div"
          >
          <div>
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
          </div>
        </Dropzone>
        {meta.touched &&
          meta.error &&
          <span className="error">{meta.error}</span>}
        {files && Array.isArray(files) &&
          files.map((file, i) => (
            <Photo key={i} file={file} i={i} />
          ))
        }
      </div>
    );
  }
}

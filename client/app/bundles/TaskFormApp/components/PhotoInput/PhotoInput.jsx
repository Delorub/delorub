import React from 'react';
import { connect } from 'react-redux'
import RenderDropzoneInput from 'libs/delorub/components/RenderDropzoneInput'
import { Field } from 'redux-form';

class PhotoInput extends React.Component {
  render() {
    const { files } = this.props

    return (
      <div>
        <Field
          name="task[files]"
          component={RenderDropzoneInput}
        />
        <div className="dr-profile-gallery">
          {files && files.map((file) =>
            <img key={file.name} src={file.preview} className="img-responsive" width="108" />
          )}
        </div>
      </div>
    )
  }
}

export default PhotoInput

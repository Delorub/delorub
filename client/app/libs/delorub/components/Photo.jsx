import React from 'react';

class Photo extends React.Component {
  setPhotoContents(contents) {
    this.refs.input.value = contents
  }

  render() {
    const { file, i } = this.props

    var reader = new FileReader();
    reader.onloadend = () => {
      this.setPhotoContents(reader.result)
    }
    reader.readAsDataURL(file)

    return (
      <div>
        <input ref="input" key={i} type="hidden" name="task[photos][]" />
      </div>
    )
  }
}

export default Photo

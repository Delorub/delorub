import React from 'react';
import Select from 'react-select';
import 'react-select/dist/react-select.css';
import classNames from 'classnames';

class RenderSelect extends React.Component {
  getComponentName() {
    if(this.props.loadOptions != undefined) {
      return Select.Async
    } else {
      return Select
    }
  }

  render() {
    const { input, data, meta, containerClasses, className, label, ...rest } = this.props

    var divClasses = classNames(
      'dr-task-name', 'dr-task-div',
      { 'dr-task-div-error': meta.touched && meta.error },
      containerClasses
    );

    const ComponentName = this.getComponentName()

    return (
      <div className={divClasses}>
        <span className="input-label">{label}</span>
        {meta.touched && meta.error &&
         <span className="error">{meta.error}</span>}
        <br />
        <ComponentName
          {...rest}
          value={input.value}
          onChange={(value) => value ? input.onChange(value.value) : input.onChange(value)}
          onBlur={() => input.onBlur(input.value)}
        />
      </div>
    )
  }
}

RenderSelect.defaultProps = {
  placeholder: 'Выберите значение',
  searchable: false,
  clearable: false,
  noResultsText: 'Ничего не найдено',
  searchPromptText: 'Введите что-нибудь для поиска',
  loadingPlaceholder: 'Загрузка...'
}

export default RenderSelect

import React from 'react';
import RenderSelect2 from 'libs/delorub/components/RenderSelect2'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

class CityInput extends React.Component {
  data(params) {
    return {
      query: params.term,
      page: params.page,
      perpage: 30
    }
  }

  processResults(data, params) {
    return {
      results: data.places.map(function(e) {
        return {
          id: e.id,
          text: e.display_name
        }
      }),
      pagination: {
        more: data.places.length == 30
      }
    }
  }

  getOptions() {
    return {
      placeholder: this.props.placeholder,
      ajax: {
        url: '/api/searches/place',
        dataType: 'json',
        delay: 250,
        data: this.data,
        processResults: this.processResults,
        cache: true
      }
    }
  }

  render() {
    return (
      <Field
        ref="selectField"
        component={RenderSelect2}
        className="dr-task-select"
        options={this.getOptions()}
        label={this.props.label}
        validate={[required]}
        {...this.props}
        />
    )
  }
}

CityInput.defaultProps = {
  placeholder: 'Выберите город',
  label: 'Город',
  name: 'place_id'
}

export default CityInput

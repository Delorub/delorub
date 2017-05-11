import React from 'react';
import { renderSelect2 } from 'libs/delorub/redux-form-select2'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

class CityInput extends React.Component {
  render() {
    var _options = {
      placeholder: this.props.placeholder,
      ajax: {
        url: '/api/searches/place',
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            query: params.term,
            page: params.page,
            perpage: 30
          }
        },
        processResults: function (data, params) {
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
          };
        },
        cache: true
      }
    }

    return (
      <Field
        component={renderSelect2}
        className="dr-task-select"
        options={_options}
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

import React from 'react';
import Select2 from 'react-select2-wrapper';

export default class PlaceInput extends React.Component {
  render() {
    var _options = {
      placeholder: 'Выберите город',
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
      <Select2 options={ _options}/>
    );
  }
}

import React from 'react';
import Select2 from 'react-select2-wrapper';

export default class PlaceInput extends React.Component {
  render() {
    var _options = {
      placeholder: 'Выберите город',
      ajax: {
        url: "/api/searches/place",
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            query: params.term,
            page: params.page
          }
        }
      }
    }

    return (
      <Select2 options={ _options}/>
    );
  }
}

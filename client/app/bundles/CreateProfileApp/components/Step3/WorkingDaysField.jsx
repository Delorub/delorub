import React from 'react';
import TimeInput from 'time-input';
import classNames from 'classnames';
import moment from 'moment';
import { Field } from 'redux-form';

export default class WorkingDaysField extends React.Component {
  render() {
    const { input, meta, label, days, ...rest } = this.props

    return (
      <div className="btn-group dr-checkbox">
        {days.map((day, index) =>
          <label className="btn btn-primary week-odd" key={index}>
            <input type="checkbox"
              name={`${input.name}[${index}]`}
              value={day[1]}
              checked={input.value.indexOf(day[1]) !== -1}
              onChange={event => {
                console.log(1)
                const newValue = [...input.value];
                if(event.target.checked) {
                  newValue.push(day[1]);
                } else {
                  newValue.splice(newValue.indexOf(day[1]), 1);
                }
                return input.onChange(newValue);
              }}/>
            <span>{day[0]}</span>
          </label>
        )}
      </div>
    )
  }
}

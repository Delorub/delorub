import React from 'react';
import { connect } from 'react-redux'
import DateActual from './DateActual';
import DateInterval from './DateInterval';

export default class DateSelector extends React.Component {
  render() {
    const { date_type } = this.props

    if(date_type == 'actual') {
      return (<DateActual {...this.props} />);
    } else if(date_type == 'interval') {
      return (<DateInterval {...this.props} />);
    } else {
      return null;
    }
  }
}

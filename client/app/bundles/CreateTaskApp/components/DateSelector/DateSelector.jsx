import React from 'react';
import { connect } from 'react-redux'
import DateActual from './DateActual';

class DateSelector extends React.Component {
  render() {
    const { date_type } = this.props

    if(date_type == 'actual') {
      return <DateActual />;
    } else if(date_type == 'interval') {
      return <DateInterval />;
    }
  }
}

function mapStateToProps(state) {
  return {
    date_type: state.$$taskStore.task.date_type,
  }
}

export default connect(mapStateToProps)(DateSelector)

import React from 'react';
import DatePicker from 'react-datepicker';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as taskActions from '../../actions/TaskActions'
import 'react-datepicker/dist/react-datepicker.css';

class DateActual extends React.Component {
  handleChange(e) {

  }

  render() {
    return (
      <div className="dr-task-date dr-task-div">
        <span>Дата&nbsp;*</span>
        <br />
        <DatePicker
          onChange={this.handleChange}
        />
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    date_actual: state.$$taskStore.task.date_actual,
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(taskActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(DateActual)

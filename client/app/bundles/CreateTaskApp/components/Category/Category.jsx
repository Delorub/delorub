import React from 'react';
import Select2 from 'react-select2-wrapper';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as taskActions from '../../actions/TaskActions'

class Category extends React.Component {
  handleChange(e) {
    this.props.selectMainCategory(e.target.value)
  }

  listCategories() {
    var categories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        categories.push({
          id: category.id,
          text: category.title
        });
      }
    });

    return categories
  }

  render() {
    const { main_category_id } = this.props

    return (
      <div className="dr-task-paid-functions dr-task-div">
        <span>Категория задания *</span>
        <br />
        <Select2
          value={main_category_id}
          onSelect={::this.handleChange}
          className="dr-task-select"
          data={this.listCategories()}
          options={{
            placeholder: 'Выберите категорию',
          }}
        />
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    main_category_id: state.$$taskStore.task.main_category_id
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(taskActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Category)

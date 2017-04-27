import React from 'react';
import Select2 from 'react-select2-wrapper';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import classNames from 'classnames'
import * as taskActions from '../../actions/TaskActions'

class Subcategory extends React.Component {
  handleChange(e) {
    this.props.selectSubcategory(e.target.value)
  }

  listCategories() {
    const { main_category_id } = this.props
    var categories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == main_category_id) {
        categories.push({
          id: category.id,
          text: category.title
        });
      }
    });

    return categories
  }

  render() {
    const { category_id, main_category_id } = this.props

    const itemClasses = classNames({
      'dr-task-paid-functions': true,
      'dr-task-div': true,
    });

    return (
      <div className={itemClasses}>
        <span>Подкатегория задания *</span>
        <br />
        <Select2
          value={category_id}
          onSelect={::this.handleChange}
          className="dr-task-select"
          data={this.listCategories()}
          options={{
            placeholder: 'Выберите подкатегорию',
          }}
          disabled={main_category_id == null}
        />
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    main_category_id: state.$$taskStore.task.main_category_id,
    category_id: state.$$taskStore.task.category_id
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(taskActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(Subcategory)

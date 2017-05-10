import React from 'react';
import { renderSelect2 } from 'libs/delorub/redux-form-select2'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class Subcategory extends React.Component {
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
    const { main_category_id } = this.props

    return (
      <Field
        component={renderSelect2}
        className="dr-task-select"
        name="category_id"
        data={this.listCategories()}
        options={{
          placeholder: 'Выберите подкатегорию',
        }}
        label="Подкатегория задания"
        validate={[required]}
        disabled={main_category_id == null}
        />
    )
  }
}

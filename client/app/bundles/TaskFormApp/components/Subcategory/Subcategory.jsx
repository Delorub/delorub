import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class Subcategory extends React.Component {
  listCategories() {
    const { main_category_id } = this.props
    var categories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == main_category_id) {
        categories.push({
          value: category.id,
          label: category.title
        });
      }
    });

    return categories
  }

  render() {
    const { main_category_id } = this.props

    return (
      <Field
        component={RenderSelect}
        className="dr-task-select"
        name="task[category_id]"
        options={this.listCategories()}
        placeholder="Выберите подкатегорию"
        label="Подкатегория задания"
        validate={[required]}
        disabled={main_category_id == null}
        searchable={true}
        clearable={false}
        />
    )
  }
}

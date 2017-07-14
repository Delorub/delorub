import React from 'react';
import RenderSelect from 'libs/delorub/components/RenderSelect'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class Category extends React.Component {
  onChange(e, v) {
    if(v != this.props.main_category_id) {
      this.props.change('task[category_id]', null)
    }
  }

  listCategories() {
    var categories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        categories.push({
          value: category.id,
          label: category.title
        });
      }
    });

    return categories
  }

  render() {
    return (
      <Field
        component={RenderSelect}
        className="dr-task-select"
        name="task[main_category_id]"
        options={this.listCategories()}
        placeholder="Выберите категорию"
        label="Категория задания"
        onChange={::this.onChange}
        validate={[required]}
        searchable={true}
        clearable={false}
        />
    )
  }
}

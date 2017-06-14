import React from 'react';
import RenderSelect2 from 'libs/delorub/components/RenderSelect2'
import { required } from 'libs/delorub/redux-form-validations'
import { Field } from 'redux-form';

export default class Category extends React.Component {
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
    return (
      <Field
        component={RenderSelect2}
        className="dr-task-select"
        name="task[main_category_id]"
        data={this.listCategories()}
        options={{
          placeholder: 'Выберите категорию',
        }}
        label="Категория задания"
        validate={[required]}
        />
    )
  }
}

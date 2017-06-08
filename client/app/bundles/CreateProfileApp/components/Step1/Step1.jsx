import React from 'react';
import Category from './Category';
import renderSpecializations from './renderSpecializations';
import Navigation from '../Navigation/Navigation';
import Buttons from '../Buttons/Buttons';
import { Field, reduxForm, formValueSelector } from 'redux-form';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as formActions from '../../actions/FormActions'

class Step1 extends React.Component {
  componentDidMount() {
    this.handleInitialize();
  }

  handleInitialize() {
    if(!this.props.main_specialization_id) {
      this.props.initialize({ create_profile: this.props.create_profile })
    }
  }

  renderCategory(field) {
    return (
      <div>
        {field.meta.touched && field.meta.error &&
         <span className="error">{field.meta.error}</span>}
        <input type="hidden" {...field.input} />
      </div>)
  }

  render() {
    const { main_specialization_id, handleSubmit } = this.props
    var listCategories = [], listSubcategories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        listCategories.push(<Category key={category.id} {...this.props} {...category} />);
      }
    }, this);

    this.props.categories.forEach(function(category) {
      if (category.parent_id == main_specialization_id) {
        listSubcategories.push(category);
      }
    }, this);

    const requiredMainSpecialization = value =>
      value ? undefined : 'Выберите основную специализацию'

    const requiredSpecializations = value =>
      value.length > 0 ? undefined : 'Выберите хотя бы одну специализацию'

    return (
      <form onSubmit={handleSubmit}>
        <Navigation />
        <div>
          <div className="dr-bottom-service">
            <div className="row">
              {listCategories}
            </div>
            <Field
              component={this.renderCategory}
              name="create_profile[main_specialization_id]"
              validate={[requiredMainSpecialization]}
            />
          </div>
          { main_specialization_id != null && listSubcategories.length > 0 &&
            <div className="profileRefinement">
              <Field
                component={renderSpecializations}
                name="create_profile[specializations]"
                specializations={listSubcategories}
                columns="4"
                validate={[requiredSpecializations]}
              />
            </div>
          }
        </div>
        <Buttons />
      </form>
    );
  }
}

const selector = formValueSelector('wizard')

Step1 = connect(
  state => ({
    main_specialization_id: selector(state, 'create_profile[main_specialization_id]'),
    specializations: selector(state, 'create_profile[specializations]'),
  }),
  dispatch => (bindActionCreators(formActions, dispatch))
)(Step1)

export default reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(Step1)

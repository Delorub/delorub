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
    this.props.initialize({ create_profile: this.props.create_profile });
  }

  handleOnSubmit(e) {
    console.log(this.props.valid);
    this.props.nextStep()
  }

  render() {
    const { main_specialization_id, handleSubmit } = this.props
    var listCategories = [], listSubcategories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        listCategories.push(<Category key={category.id} {...this.props} {...category} />);
      }
    }, this);

    var currentCol = 0
    this.props.categories.forEach(function(category) {
      if (category.parent_id == main_specialization_id) {
        currentCol++
        if(currentCol > 4) {
          currentCol = 1
        }
        if(listSubcategories[currentCol] == undefined) {
          listSubcategories[currentCol] = []
        }
        listSubcategories[currentCol].push(<Subcategory key={category.id} {...this.props} {...category} />);
      }
    }, this);

    return (
      <form ref="formComponent" onSubmit={handleSubmit(::this.handleOnSubmit)}>
        <Navigation />
        <div>
          <div className="dr-bottom-service">
            <div className="row">
              {listCategories}
            </div>
          </div>
          { main_specialization_id != null &&
            <div className="profileRefinement">
              <input type="hidden" name="main_specialization_id" value={main_specialization_id} />
              <Field
                component={renderSpecializations}
                name="create_profile[specializations]"
                specializations={listSubcategories}
                main_specialization_id
              />
            </div>
          }
        </div>
        <Buttons />
      </form>
    );
  }
}

const validate = values => {
  const create_profile = values.create_profile
  const errors = {}

  if (create_profile.specializations && create_profile.specializations.length == 0) {
    create_profile.specializations = 'Required'
  }

  create_profile.specializations = 'Required'
  return errors
}

const selector = formValueSelector('create_profile')

Step1 = reduxForm({
  form: 'create_profile',
  validate
})(Step1);

Step1 = connect(
  state => ({
    main_specialization_id: selector(state, 'create_profile[main_specialization_id]'),
    specializations: selector(state, 'create_profile[specializations]'),
  }),
  dispatch => (bindActionCreators(formActions, dispatch))
)(Step1)

export default Step1

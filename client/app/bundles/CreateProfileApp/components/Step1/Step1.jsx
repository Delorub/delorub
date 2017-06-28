import React from 'react';
import MainCategory from './MainCategory';
import renderCategories from './renderCategories';
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
    this.props.create_profile.categories = this.props.create_profile.categories.map((e) => (parseInt(e)))

    if(!this.props.main_category_id) {
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
    const { main_category_id, handleSubmit } = this.props
    var listCategories = [[]], listSubcategories = []

    var i = 0;
    var row = 0;
    this.props.all_categories.forEach(function(category) {
      if (category.parent_id == null) {
        i++
        if(i > 8) {
          i = -1
          row++
          listCategories[row] = []
        }
        if(row % 2 == 1) {
          var className = 'dr-bottom-service-even-row-category'
        } else {
          var className = 'dr-bottom-service-odd-row-category'
        }
        listCategories[row].push(<MainCategory className={className} key={category.id} {...this.props} {...category} />);
      }
    }, this);

    this.props.all_categories.forEach(function(category) {
      if (category.parent_id == main_category_id) {
        listSubcategories.push(category);
      }
    }, this);

    const requiredMainCategory = value =>
      value ? undefined : 'Выберите основную специализацию'

    const requiredCategories = value =>
      value.length > 0 ? undefined : 'Выберите хотя бы одну специализацию'

    return (
      <form onSubmit={handleSubmit}>
        <Navigation />
        <div className="dr-profile">
          <div className="dr-bottom-service">
              {listCategories.map((row, index) => (
                <div className="dr-bottom-service-odd-row" key={index}>
                  {row}
                </div>
              ))}
            <Field
              component={this.renderCategory}
              name="create_profile[main_category_id]"
              validate={[requiredMainCategory]}
            />
          </div>
          { main_category_id != null && listSubcategories.length > 0 &&
            <div className="profileRefinement">
              <Field
                component={renderCategories}
                name="create_profile[categories]"
                subcategories={listSubcategories}
                columns="4"
                validate={[requiredCategories]}
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
    main_category_id: selector(state, 'create_profile[main_category_id]'),
    categories: selector(state, 'create_profile[categories]'),
  }),
  dispatch => (bindActionCreators(formActions, dispatch))
)(Step1)

export default reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(Step1)

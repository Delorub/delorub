import React from 'react';
import Navigation from '../Navigation/Navigation';
import Buttons from '../Buttons/Buttons';
import Fields from './Fields';
import PriceTypeInput from './PriceTypeInput'
import PriceSelector from './PriceSelector'
import Verification from './Verification'
import YesNoField from './YesNoField'
import WorkingDaysField from './WorkingDaysField'
import { required, time } from 'libs/delorub/redux-form-validations'
import { normalizeTime } from 'libs/delorub/redux-form-normalizers'
import { renderField } from 'libs/delorub/redux-form-input'
import { Field, reduxForm, formValueSelector } from 'redux-form';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as formActions from '../../actions/FormActions'

class Step3 extends React.Component {
  handleOnSubmit(e) {
    this.refs.formComponent.submit()
  }

  render() {
    const { handleSubmit } = this.props

    return (
      <form
        ref="formComponent"
        acceptCharset="UTF-8"
        action={this.props.form_action}
        method="post"
        onSubmit={handleSubmit(::this.handleOnSubmit)}
        >
        <input type="hidden" name="utf8" value="✓" />
        <input name="authenticity_token" value={this.props.authenticity_token} type="hidden" />
        { this.props.create_profile.profile_id && ( <input name="_method" value="PUT" type="hidden" />) }
        <Navigation />
        <Fields />
        <div className="row">
          <div className="col-md-3">
            <Field
              component={YesNoField}
              name="create_profile[have_car]"
              label="Наличие автомобиля"
              />
          </div>
          <div className="col-md-3">
            <Field
              component={YesNoField}
              name="create_profile[have_instrument]"
              label="Наличие своего инструмента"
              />
          </div>
          <div className="col-md-3">
            <Field
              component={YesNoField}
              name="create_profile[can_departure]"
              label="Выезд/прием на дому"
              />
          </div>
          <div className="col-md-3">
            <PriceTypeInput {...this.props} />
          </div>
        </div>
        <div className="row">
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span className="input-label">Рабочие дни&nbsp;</span>
              <label className="worktime">
                <Field
                  component="input"
                  type="checkbox"
                  name="create_profile[working_all_time]"
                  />
                &nbsp;24 часа/без выходных
              </label>
              <br />
              <Field
                component={WorkingDaysField}
                name="create_profile[working_days]"
                label="Выезд/прием на дому"
                days={this.props.create_profile.working_days_options}
                />
            </div>
          </div>
          <div className="col-md-3">
            <div className="dr-task dr-profile-div dr-task-date">
              <span className="input-label">Рабочее время</span>
              <br />
              <Field
                component={renderField}
                type="text"
                label=""
                containerClasses={[]}
                className="form-control"
                name="create_profile[working_hours_from]"
                placeholder="С"
                validate={[required, time]}
                normalize={normalizeTime}
                />
              <Field
                component={renderField}
                type="text"
                label=""
                containerClasses={[]}
                className="form-control"
                name="create_profile[working_hours_to]"
                placeholder="До"
                validate={[required, time]}
                normalize={normalizeTime}
                />
            </div>
          </div>
          <div className="col-md-offset-3 col-md-3">
            <PriceSelector {...this.props} />
          </div>
        </div>
        <Buttons />
      </form>
    );
  }
}

const selector = formValueSelector('wizard')

Step3 = reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(Step3);

Step3 = connect(
  state => ({
    price_type: selector(state, 'create_profile[price_type]'),
  }),
  dispatch => (bindActionCreators(formActions, dispatch))
)(Step3)

export default Step3

import React from 'react';
import Navigation from '../Navigation/Navigation';
import Buttons from '../Buttons/Buttons';
import Fields from './Fields';
import Select2 from 'react-select2-wrapper';
import PriceTypeInput from './PriceTypeInput'
import PriceSelector from './PriceSelector'
import YesNoField from './YesNoField'
import WorkingDaysField from './WorkingDaysField'
import { Field, reduxForm, formValueSelector } from 'redux-form';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as formActions from '../../actions/FormActions'
import { required, requiredArray } from 'libs/delorub/redux-form-validations'
import RenderTimePickerField from 'libs/delorub/redux-form-timepicker'

class Step3 extends React.Component {
  handleOnSubmit(e) {
    this.refs.formComponent.submit()
  }

  render() {
    const { handleSubmit } = this.props

    return (
      <form ref="formComponent" onSubmit={handleSubmit(::this.handleOnSubmit)}>
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
              <span class="input-label">Рабочие дни&nbsp;</span>
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
              <span class="input-label">Рабочее время</span>
              <br />
              <Field
                component={RenderTimePickerField}
                name="create_profile[working_hours_from]"
                />
              <Field
                component={RenderTimePickerField}
                name="create_profile[working_hours_to]"
                />
            </div>
          </div>
          <div className="col-md-offset-3 col-md-3">
            <PriceSelector {...this.props} />
          </div>
        </div>
        <div className="dr-header-span lastRow">
          <p>
            Верификация <span className="dr-header-span-unmarked">&nbsp;аккаунта</span>
          </p>
        </div>
        <div className="dr-header-span dr-header-span-complete">
          <p>
            Спасибо. <span className="dr-header-span-unmarked">&nbsp;Ваш телефон подтвержден. Верификация аккаунта прошла успешно!</span>
          </p>
        </div>
        <div className="row rowWithOutPadding">
          <div className="col-md-4">
            <div className="dr-profile-verification">
              <span>1</span>
              <p>
                Введите номер<br /> телефона
              </p>
            </div>
          </div>
          <div className="col-md-4">
            <div className="dr-profile-verification dr-profile-verification-middle">
              <span>2</span>
              <p>
                Введите присланный<br /> код из СМС
              </p>
            </div>
          </div>
          <div className="col-md-4">
            <div className="dr-profile-verification">
              <span>3</span>
              <p>
                Нажмите кнопку<br /> "Подтвердить телефон"
              </p>
            </div>
          </div>
        </div>
        <div className="row rowWithOutPadding lastRow">
          <div className="col-md-offset-4 col-md-4">
            <div className="dr-profile-phoneCheck">
              <br />
              <span>Введите номер вашего<br /> телефона *</span>
              <br />
              <input type="text" className="form-control" placeholder="" />
              <button type="button" className="btn dr-button-blue">Выслать код в смс</button>
            </div>
          </div>
        </div>
        <div className="row rowWithOutPadding lastRow">
          <div className="col-md-offset-4 col-md-4">
            <div className="dr-profile-phoneCheck">
              <br />
              <span>Введите проверочный код<br /> из СМС сообщения *</span>
              <br />
              <input type="text" className="form-control" placeholder="" />
              <button type="button" className="btn dr-button-blue">Подтвердить телефон</button>
            </div>
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

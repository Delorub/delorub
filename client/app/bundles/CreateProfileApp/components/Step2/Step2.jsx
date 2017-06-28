import React from 'react';
import Navigation from '../Navigation/Navigation';
import Buttons from '../Buttons/Buttons';
import PhotoInput from './PhotoInput';
import { Field, reduxForm, formValueSelector } from 'redux-form';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import * as formActions from '../../actions/FormActions'
import { required, minLength } from 'libs/delorub/redux-form-validations'
import { renderField } from 'libs/delorub/redux-form-textarea'
import RenderSelect from 'libs/delorub/components/RenderSelect'
import PhotosInput from 'libs/delorub/components/PhotosInput'
import { optionsToSelect2 } from 'libs/delorub/options-to-select2'
import CityInput from 'libs/delorub/components/CityInput';

class Step2 extends React.Component {
  handleOnSubmit(e) {
    this.props.nextStep()
  }

  render() {
    const { handleSubmit } = this.props

    const minLength10 = minLength(10)

    return (
      <form onSubmit={handleSubmit(::this.handleOnSubmit)}>
        <Navigation />
        <div className="row row-eq-height dr-task">
          <div className="col-md-3">
            <PhotoInput {...this.props} />
          </div>
          <div className="col-md-6">
            <Field
              component={renderField}
              className="form-control"
              name="create_profile[about]"
              label="Описание"
              placeholder="Введите описание"
              validate={[required, minLength10]}
              />
          </div>
          <div className="col-md-3">
            <CityInput name="create_profile[place_id]" />
          </div>
        </div>

        <div className="row row-eq-height dr-task lastRow">
          <div className="col-md-6">
            <div className="dr-task-div">
              <span>Фото примеров работ</span>
            </div>
            <PhotosInput
              label=""
              inputName="create_profile[portfolio_items][][id]"
              fieldName="create_profile[portfolio_items]"
              apiUrl="/api/portfolio_items"
              fieldId="id"
              fieldPreview="upload_preview_url"
              {...this.props}
            />
            <Field
              component={RenderSelect}
              className="dr-task-select"
              name="create_profile[paid_functions]"
              options={optionsToSelect2(this.props.create_profile.paid_functions_options)}
              placeholder="Выберите платные функции для вашего задания"
              clearable={true}
              label="Платные функции"
              />
          </div>

          <div className="col-md-6">
            <div className="dr-task-div">
              <span>Дипломы и сертификаты</span>
            </div>
            <PhotosInput
              label=""
              inputName="create_profile[certificates][][id]"
              fieldName="create_profile[certificates]"
              apiUrl="/api/certificates"
              fieldId="id"
              fieldPreview="upload_preview_url"
              {...this.props}
            />
            <Field
              component={RenderSelect}
              className="dr-task-select"
              name="create_profile[notifications_type]"
              options={optionsToSelect2(this.props.create_profile.notifications_type_options)}
              placeholder="Выберите формат уведомлений"
              label="Формат уведомлений об откликах"
              validate={[required]}
              />
          </div>
        </div>
        <Buttons />
      </form>
    );
  }
}

const selector = formValueSelector('wizard')

Step2 = connect(
  state => ({
    photo_url: selector(state, 'create_profile[photo_url]'),
  }),
  dispatch => (bindActionCreators(formActions, dispatch))
)(Step2)

export default reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(Step2)

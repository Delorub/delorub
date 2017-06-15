import React from 'react';
import { connect } from 'react-redux'
import Title from '../Title/Title';
import Budget from '../Budget/Budget';
import Category from '../Category/Category';
import DateSelector from '../DateSelector/DateSelector';
import Subcategory from '../Subcategory/Subcategory';
import PhotoInput from '../PhotoInput/PhotoInput';
import DescriptionInput from '../DescriptionInput/DescriptionInput';
import DateTypeInput from '../DateTypeInput/DateTypeInput';
import ContractInput from '../ContractInput/ContractInput';
import NotificationsTypeInput from '../NotificationsTypeInput/NotificationsTypeInput';
import PaidFunctionsInput from '../PaidFunctionsInput/PaidFunctionsInput';
import CityInput from 'libs/delorub/components/CityInput';
import AddressInput from 'libs/delorub/components/AddressInput';
import Select2 from 'react-select2-wrapper';
import { Field, reduxForm, formValueSelector } from 'redux-form';

class App extends React.Component {
  componentDidMount() {
    this.handleInitialize();
  }

  handleInitialize() {
    this.props.initialize({ task: this.props.task });
  }

  handleOnSubmit() {
    this.refs.formComponent.submit();
  }

  render() {
    const { handleSubmit, pristine, reset, submitting } = this.props

    return (
      <form
        ref="formComponent"
        acceptCharset="UTF-8"
        action={this.props.form_action}
        method="post"
        onSubmit={handleSubmit(::this.handleOnSubmit)}
        enctype="multipart/form-data"
        >
        <input type="hidden" name="utf8" value="✓" />
        <input name="authenticity_token" value={this.props.authenticity_token} type="hidden" />
        <div className="dr-header-span">
          <p>Создание <span className="dr-header-span-unmarked">&nbsp;задания</span></p>
          <input type="submit" className="btn dr-button-empty" value="Предпросмотр" />
        </div>
        <div className="row row-eq-height dr-task">
          <div className="col-md-5">

            <Title />

            <DescriptionInput />

            <PhotoInput {...this.props} />

            <PaidFunctionsInput {...this.props} />

          </div>
          <div className="col-md-7">

            <Budget {...this.props}/>

            <div className="row row-eq-height">
              <div className="col-md-6">

                <DateTypeInput {...this.props} />

                <CityInput name="task[place_id]" />

                <Category {...this.props} />

                <ContractInput {...this.props} />

              </div>

              <div className="col-md-6">

                <DateSelector {...this.props} />

                <AddressInput name="task[place_address]" />

                <Subcategory {...this.props} />

                <NotificationsTypeInput {...this.props} />

              </div>
            </div>
          </div>
        </div>
        <div className="row lastRow">
          <button type="submit" className="btn dr-button-blueFull" disabled={pristine || submitting}>Добавить задание</button>
        </div>
      </form>
    );
  }
}

const selector = formValueSelector('task')

App = reduxForm({
  form: 'task'
})(App);

App = connect(
  state => ({
    price_exact: selector(state, 'task[price_exact]'),
    date_type: selector(state, 'task[date_type]'),
    main_category_id: selector(state, 'task[main_category_id]'),
    files: selector(state, 'task[files]'),
  })
)(App)

export default App

import React from 'react';
import { connect } from 'react-redux'
import Title from '../Title/Title';
import Budget from '../Budget/Budget';
import Category from '../Category/Category';
import DateSelector from '../DateSelector/DateSelector';
import Subcategory from '../Subcategory/Subcategory';
import Select2 from 'react-select2-wrapper';
import { Field, reduxForm, formValueSelector } from 'redux-form';

class App extends React.Component {
  componentDidMount() {
    this.handleInitialize();
  }

  handleInitialize() {
    this.props.initialize(this.props.task);
  }

  handleOnSubmit() {
    this.refs.formComponent.submit();
  }

  render() {
    const { handleSubmit, pristine, reset, submitting } = this.props

    return (
      <form ref="formComponent" action="asd" method="post" onSubmit={handleSubmit(::this.handleOnSubmit)}>

        <div className="dr-header-span">
          <p>Создание <span className="dr-header-span-unmarked">&nbsp;задания</span></p>
          <input type="submit" className="btn dr-button-empty" value="Предпросмотр" />
        </div>
        <div className="row row-eq-height dr-task">
          <div className="col-md-5">
            <Title />
            <div className="dr-task-description dr-task-div">
              <span>Описание задания *</span>
              <textarea name="name" rows="6" cols="60" className="form-control" placeholder="Введите описание задания"></textarea>
            </div>
            <div className="dr-task-photo dr-task-div">
              <div className="row">
                <div className="col-md-6">
                  <span>Фото&nbsp;*</span>
                  <br />
                  <button type="button" className="btn dr-button-blue">Выбрать фото</button>
                </div>
                <div className="col-md-6">
                  <span className="icon_top icon-information"></span>
                  <p className="photoInfo">
                    Максимальный размер файла 5 МБ, формат .jpg, .jpeg, .png, .gif.
                  </p>
                </div>
              </div>
            </div>
            <div className="dr-task-paid-functions dr-task-div">
              <span>Платные функции</span>
              <br />
              <Select2
                data={[
                  { text: 'Размещение в ТОП заданий — 500Р (3 дня)', id: '1' },
                ]}
                data-minimum-results-for-search="Infinity"
              />
            </div>
          </div>

          <div className="col-md-7">
            <Budget />
            <div className="row row-eq-height">

              <div className="col-md-6">
                <div className="dr-task-paid-functions dr-task-div">
                  <span>Сроки&nbsp;*</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Завершить работу</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Город&nbsp;*</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Москва</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <Category categories={this.props.categories} />

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Заключение договора</span>
                  <br />
                  <Select2
                    data={[
                      { text: 'Без договора', id: '1' },
                    ]}
                    data-minimum-results-for-search="Infinity"
                  />
                </div>

              </div>

              <div className="col-md-6">

                <DateSelector date_type={this.props.date_type} />

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Адрес</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Москва</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <Subcategory categories={this.props.categories} main_category_id={this.props.main_category_id} />

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Формат уведомлений об откликах</span>
                  <br />
                  <Select2
                    data={[
                      { text: 'На email и в уведомлениях', id: 'email-notifications' },
                      { text: 'Только уведомления', id: 'notifications' },
                    ]}
                    data-minimum-results-for-search="Infinity"
                  />
                </div>
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
    date_type: selector(state, 'date_type'),
    main_category_id: selector(state, 'main_category_id'),
  })
)(App)

export default App

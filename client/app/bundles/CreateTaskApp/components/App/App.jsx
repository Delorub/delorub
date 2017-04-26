import React from 'react';

export default class App extends React.Component {
  render() {
    return (
      <div className="dr-container">
        <div className="dr-header-span">
          <p>
            Создание <span className="dr-header-span-unmarked">&nbsp;задания</span>
          </p>
          <button type="button" className="btn dr-button-empty">Предпросмотр</button>
        </div>
        <div className="row row-eq-height dr-task">
          <div className="col-md-5">
            <div className="dr-task-name dr-task-div">
              <span>Название задания *</span>
              <input type="text" className="form-control" placeholder="Введите название задания" />
            </div>
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
                    Максимальный размер файла 5 МБ, формат .jpg, .jpeg, .png, .gif.<br /> <b>Обратите внимание:</b> профили без фото не допускаются.
                  </p>
                </div>
              </div>
            </div>
            <div className="dr-task-paid-functions dr-task-div">
              <span>Платные функции</span>
              <br />
              <select className="dr-task-select">
                <option>Пункт 1</option>
                <option>Пункт 2</option>
              </select>
            </div>
          </div>

          <div className="col-md-7">
            <div className="dr-task-budget dr-task-div">
              <div className="row">
                <div className="col-md-4">
                  <span>Бюджет&nbsp;*</span>
                  <input type="text" className="form-control" placeholder="300 000" />
                </div>
                <div className="col-md-8">
                  <span className="minValue">0</span>
                  <span className="maxValue">300 000</span>
                  <input id="ex1" data-slider-id='ex1Slider' type="text" data-slider-min="0" data-slider-max="300" data-slider-step="1" data-slider-value="240" />
                </div>
              </div>
            </div>
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

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Категория задания&nbsp;*</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Фото- и видеосъемка</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Заключение договора</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Без договора</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

              </div>

              <div className="col-md-6">
                <div className="dr-task-date dr-task-div">
                  <span>Дата&nbsp;*</span>
                  <br />
                  <input type="date" name="user_date" />
                  <input type="time" name="user_time" />
                </div>

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Адрес</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Москва</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Подкатегория задания</span>
                  <br />
                  <select className="dr-task-select">
                    <option>Фотосъемка</option>
                    <option>Пункт 2</option>
                  </select>
                </div>

                <div className="dr-task-paid-functions dr-task-div">
                  <span>Формат уведомлений об откликах</span>
                  <br />
                  <select className="js-example-tags select2">
                    <option value="AL">На email и уведомления</option>
                    <option value="WY">Wyoming</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="row lastRow">
          <button type="button" className="btn dr-button-blueFull">Добавить задание</button>
        </div>
      </div>
    );
  }
}

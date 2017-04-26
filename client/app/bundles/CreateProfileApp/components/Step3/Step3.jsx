import React from 'react';

export default class Step3 extends React.Component {
  render() {
    return (
      <div>
        <div className="row">
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Наличие автомобиля</span>
              <br />
              <div className="btn-group dr-radio" data-toggle="buttons">
                <label className="btn btn-primary active">
                  <input type="radio" name="car" id="option1" autoComplete="off" />
                  <span>Да</span>
                </label>
                <label className="btn btn-primary">
                  <input type="radio" name="car" id="option2" autoComplete="off" />
                  <span>Нет</span>
                </label>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Наличие своего инструмента</span>
              <br />
              <div className="btn-group dr-radio" data-toggle="buttons">
                <label className="btn btn-primary active">
                  <input type="radio" name="tools" id="option1" autoComplete="off" />
                  <span>Да</span>
                </label>
                <label className="btn btn-primary">
                  <input type="radio" name="tools" id="option2" autoComplete="off" />
                  <span>Нет</span>
                </label>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Выезд/прием на дому</span>
              <br />
              <div className="btn-group dr-radio" data-toggle="buttons">
                <label className="btn btn-primary active">
                  <input type="radio" name="visit" id="option1" autoComplete="off" />
                  <span>Да</span>
                </label>
                <label className="btn btn-primary">
                  <input type="radio" name="visit" id="option2" autoComplete="off" />
                  <span>Нет</span>
                </label>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Вариант оплаты&nbsp;*</span>
              <br />
              <select className="dr-task-select">
                <option>Цена за час</option>
                <option>Пункт 2</option>
              </select>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Рабочие дни</span>
              <input type="checkbox" name="worktime" className="worktime" />
              <span className="worktime">24 часа/без выходных</span>
              <br />
              <div className="btn-group dr-checkbox" data-toggle="buttons">
                <label className="btn btn-primary week-odd">
                  <input type="checkbox" checked autoComplete="off" />
                  <span>Пн</span>
                </label>
                <label className="btn btn-primary">
                  <input type="checkbox" autoComplete="off" />
                  <span>Вт</span>
                </label>
                <label className="btn btn-primary week-odd">
                  <input type="checkbox" autoComplete="off" />
                  <span>Ср</span>
                </label>
                <label className="btn btn-primary">
                  <input type="checkbox" autoComplete="off" />
                  <span>Чт</span>
                </label>
                <label className="btn btn-primary week-odd">
                  <input type="checkbox" autoComplete="off" />
                  <span>Пт</span>
                </label>
                <label className="btn btn-primary week-end">
                  <input type="checkbox" autoComplete="off" />
                  <span>Сб</span>
                </label>
                <label className="btn btn-primary week-end">
                  <input type="checkbox" autoComplete="off" />
                  <span>Вс</span>
                </label>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <div className="dr-task dr-profile-div dr-task-date">
              <span>Рабочее время</span>
              <br />
              <input type="time" name="user_time" />
              <input type="time" name="user_time" />
            </div>
          </div>
          <div className="col-md-offset-3 col-md-3">
            <div className="dr-task dr-profile-div">
              <span>Почасовая ставка&nbsp;*</span>
              <br />
              <select className="dr-task-select">
                <option>300 000</option>
                <option>Пункт 2</option>
              </select>
            </div>
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
      </div>
    );
  }
}

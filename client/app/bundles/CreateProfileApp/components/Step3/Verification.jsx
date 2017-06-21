import React from 'react';
import request from 'superagent';

export default class Verification extends React.Component {
  render() {
    return (
      <div>
        <div className="dr-header-span lastRow">
          <p>
            Верификация <span className="dr-header-span-unmarked">&nbsp;аккаунта</span>
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
          <div className="col-md-4">
            <div className="dr-profile-phoneCheck">
              <br />
              <span>Введите номер вашего<br /> телефона *</span>
              <br />
              <input type="text" className="form-control" placeholder="" />
              <button type="button" className="btn dr-button-blue">Выслать код в смс</button>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

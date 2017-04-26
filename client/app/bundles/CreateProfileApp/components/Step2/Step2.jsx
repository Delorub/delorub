import React from 'react';
import Select2 from 'react-select2-wrapper';
import PlaceInput from './PlaceInput';
import PhotoInput from './PhotoInput';

export default class Step2 extends React.Component {
  render() {
    return (
      <div>
      <div className="row row-eq-height dr-task">
        <div className="col-md-3">
          <div className="dr-task-photo dr-task-div center">
            <span>Фото</span>
            <PhotoInput />
            <span className="icon_top icon-information"></span>
            <p className="photoInfo">
              Максимальный размер файла 5 МБ,<br /> формат .jpg, .jpeg, .png, .gif.<br /> <b>Обратите внимание:</b> профили без фото не допускаются.
            </p>
          </div>
        </div>
        <div className="col-md-6">
          <div className="dr-task-description dr-task-div">
            <span>Описание</span>
            <textarea name="name" rows="10" cols="60" className="form-control" placeholder="Введите описание"></textarea>
          </div>
        </div>
        <div className="col-md-3">
          <div className="dr-task-paid-functions dr-task-div">
            <span>Город</span>
            <br />
            <PlaceInput />
          </div>
        </div>
      </div>

      <div className="row row-eq-height dr-task lastRow">
        <div className="col-md-6">
          <div className="dr-task-div">
            <span>Фото примеров работ</span>
          </div>
          <div className="dr-task-photo dr-task-div">
            <div className="row">
              <div className="col-md-6">
                <button type="button" className="btn dr-button-blue">Выбрать фото</button>
              </div>
              <div className="col-md-6">
                <span className="icon_top icon-information"></span>
                <p className="marginTop10">Вы можете загрузить до 10 фото.</p>
                <p className="photoInfo">
                  Максимальный размер файла 5 МБ,<br /> формат .jpg, .jpeg, .png, .gif.
                </p>
              </div>
            </div>
          </div>
          <div className="dr-profile-gallery"></div>
          <div className="dr-task-paid-functions dr-task-div">
            <span>Платные функции</span>
            <br />
              <Select2
                data={[
                  { text: 'Размещение в ТОП мастеров — 500Р (3 дня)', id: '' },
                ]}
              />
          </div>
        </div>

        <div className="col-md-6">
          <div className="dr-task-div">
            <span>Дипломы и сертификаты</span>
          </div>
          <div className="dr-task-photo dr-task-div">
            <div className="row">
              <div className="col-md-6">
                <button type="button" className="btn dr-button-blue">Выбрать фото</button>
              </div>
              <div className="col-md-6">
                <span className="icon_top icon-information"></span>
                <p className="marginTop10">Вы можете загрузить до 10 фото.</p>
                <p className="photoInfo">
                  Максимальный размер файла 5 МБ,<br /> формат .jpg, .jpeg, .png, .gif.
                </p>
              </div>
            </div>
          </div>
          <div className="dr-profile-gallery"></div>
          <div className="dr-task-paid-functions dr-task-div">
            <span>Формат уведомления об откликах</span>
            <br />
            <Select2
              data={[
                { text: 'На email и в уведомлениях', id: 'email-notifications' },
                { text: 'Только уведомления', id: 'notifications' },
              ]}
            />
          </div>
        </div>
      </div>
      </div>
    );
  }
}

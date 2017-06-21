import React from 'react';
import Steps from '../Steps/Steps';

export default class App extends React.Component {
  render() {
    return (
      <div className="dr-container">
        <div className="dr-header-span">
          <p>
            {this.props.create_profile.profile_id ? 'Редактирование' : 'Создание'} <span className="dr-header-span-unmarked">&nbsp;анкеты мастера</span>
          </p>
        </div>
        <Steps {...this.props}/>
      </div>
    );
  }
}

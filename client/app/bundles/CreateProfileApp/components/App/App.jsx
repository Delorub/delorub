import React from 'react';
import Steps from '../Steps/Steps';
import Navigation from '../Navigation/Navigation';
import Buttons from '../Buttons/Buttons';

export default class App extends React.Component {
  render() {
    return (
      <div className="dr-container">
        <div className="dr-header-span">
          <p>
            Создание <p className="dr-header-span-unmarked">&nbsp;анкеты мастера</p>
          </p>
        </div>
        <Navigation />
        <Steps {...this.props}/>
        <Buttons />
      </div>
    );
  }
}

import React from 'react';
import QuestionList from '../QuestionList/QuestionList';
import TextEditor from '../TextEditor/TextEditor';

import css from './App.scss';

export default class App extends React.Component {
  render() {
    return (
      <div className="clearfix">
        <div className={css.questionListContainer}>
          <QuestionList />
        </div>
        <div className={css.textEditorContainer}>
          <TextEditor />
        </div>
      </div>
    );
  }
}

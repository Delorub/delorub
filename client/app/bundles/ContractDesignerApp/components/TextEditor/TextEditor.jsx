import React from 'react';
import { connect } from 'react-redux'
import tinymce from 'tinymce/tinymce'
import striptags from 'striptags';
import 'tinymce/themes/modern/theme'
import TinyMCEInput from 'react-tinymce-input';
import renderComponent from '../../utils/renderComponent';
import VariantMarkup from '../Variant/VariantMarkup';
import { bindActionCreators } from 'redux'
import * as textEditorActions from '../../actions/TextEditorActions'

class TextEditor extends React.Component {
  handleChange(event) {
    this.props.changeText(event)
  }

  componentDidUpdate(prevProps) {
    if(this.props.insert_variant && this.props.insert_variant != prevProps.insert_variant) {
      this._insertVariant(this.props.insert_variant);
    }

    if(this.props.change_variant && this.props.change_variant != prevProps.change_variant) {
      this._updateVariants(this.props.change_variant);
    }

    if(this.props.change_question && this.props.change_question != prevProps.change_question) {
      this._updateQuestions(this.props.change_question);
    }
  }

  _insertVariant(variant) {
    const editor = window.tinymce.editors[0];
    const node = editor.selection.getNode();

    if(node.nodeName.toLowerCase() == 'body') {
      return;
    }

    editor.dom.addClass(node, 'block');
    editor.dom.setAttribs(node, {
      'data-variant-title': variant.title,
      'data-question-title': variant.question.title,
      'data-question-id': variant.question.id,
      'data-variant-id': variant.id
    });
  }

  _updateVariants(data) {
    const editor = window.tinymce.editors[0];
    const nodes = editor.dom.select('[data-question-id="' + data.question_id + '"][data-variant-id="' + data.id + '"]')
    editor.dom.setAttribs(nodes, {
      'data-variant-title': data.title,
    });
  }

  _updateQuestions(data) {
    const editor = window.tinymce.editors[0];
    const nodes = editor.dom.select('[data-question-id="' + data.id + '"]')

    editor.dom.setAttribs(nodes, {
      'data-question-title': data.title,
    });
  }

  _tinymceSetup(editor) {
    editor.addButton('insertvariable', {
      text: 'Вставить переменную',
      icon: false,
      onpostrender: function() {
        var btn = this;
        editor.on('NodeChange', function(e) {
          btn.disabled(e.element.nodeName.toLowerCase() == 'variable');
        });
      },
      onclick: function () {
        if(editor.selection.getContent() == '') {
          editor.windowManager.open({
            title: 'Вставить переменную',
              body: [
                { type: 'textbox', name: 'title', label: 'Название' }
              ],
              onsubmit: function(e) {
                editor.insertContent('<variable>' + striptags(e.data.title) + '</variable>');
              }
          })
        } else {
          editor.selection.setContent('<variable>' + striptags(editor.selection.getContent()) + '</variable>');
        }
      }
    });

    editor.addButton('deleteblock', {
      text: 'Удалить блок',
      icon: false,
      onpostrender: function() {
        var btn = this;
        editor.on('NodeChange', function(e) {
          btn.visible(e.element.classList.contains('block'));
        });
      },
      onclick: function () {
        editor.selection.getNode().classList.remove('block');
        editor.selection.getNode().attributes.removeNamedItem('data-question-title');
        editor.selection.getNode().attributes.removeNamedItem('data-variant-title');
        editor.selection.getNode().attributes.removeNamedItem('data-question-id');
        editor.selection.getNode().attributes.removeNamedItem('data-variant-id');
      }
    });

    editor.on('keyDown', function(event) {
      if (event.keyCode == 13) {
        if(editor.selection.getNode().nodeName.toLowerCase() == 'variable') {
          event.preventDefault();
          event.stopPropagation();
          return false;
        }
      }
    });
  }

  render() {
    return <TinyMCEInput
      name='contract_template[markup][text]'
      value={this.props.data}
      onSetupEditor={this._tinymceSetup}
      tinymceConfig={{
        plugins: 'table contextmenu lists',
        statusbar: false,
        toolbar1: 'removeformat | undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',
        toolbar2: 'insertvariable deleteblock',
        language: 'ru_RU',
        custom_elements: '~variable',
        extended_valid_elements: 'variable',
        keep_styles: false,
        width: '100%',
        height: '600px',
        content_css: '/editor.css?v=8'
      }}
      onChange={::this.handleChange}
    />;
  }
}

function mapStateToProps(state) {
  return state.$$templateStore.text
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(textEditorActions, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(TextEditor)

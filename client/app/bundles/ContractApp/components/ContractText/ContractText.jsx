import React from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Variable from './Variable';
import Block from './Block';
import * as answerActions from '../../actions/AnswerActions'
import HtmlToReact from 'html-to-react'

var isValidNode = function() {
    return true;
};

export default class ContractText extends React.Component {
  _renderText(text) {
    var parser = new HtmlToReact.Parser();
    var variableUniqueId = 0;
    var blockUniqueId = 0;
    var isRendering = this.props.rendering;
    var processNodeDefinitions = new HtmlToReact.ProcessNodeDefinitions(React);
    var processingInstructions = [
      {
        shouldProcessNode: function (node) {
          return node.name === 'variable';
        },
        processNode: function (node, children, index) {
          variableUniqueId++
          return <Variable
            key={variableUniqueId}
            id={variableUniqueId}
            title={children.join('')}
            rendering={isRendering}
          />
        }
      },
      {
        shouldProcessNode: function (node) {
          return node.type == 'tag' && node.attribs && node.attribs['class'] === 'block';
        },
        processNode: function (node, children, index) {
          blockUniqueId++
          return <Block
            key={blockUniqueId}
            data={children}
            question_id={node.attribs['data-question-id']}
            variant_id={node.attribs['data-variant-id']}
            attribs={node.attribs}
            tag={node.name}
            rendering={isRendering}
          />
        }
      },
      {
        shouldProcessNode: function (node) {
          return true;
        },
        processNode: processNodeDefinitions.processDefaultNode,
      },
    ];

    return parser.parseWithInstructions(text, isValidNode, processingInstructions);
  }

  render() {
    const { text } = this.props;

    return (
      <div className="text_container noselect">
        {this._renderText(text.data)}
      </div>
    );
  }
}

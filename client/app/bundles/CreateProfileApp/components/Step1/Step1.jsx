import React from 'react';
import Category from './Category';
import Subcategory from './Subcategory';

export default class Step1 extends React.Component {
  render() {
    var listCategories = [], listSubcategories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        listCategories.push(<Category key={category.id} {...category} />);
      }
    });

    var currentCol = 0
    this.props.categories.forEach(function(category) {
      if (category.id != null) {
        currentCol++
        if(currentCol > 4) {
          currentCol = 1
        }
        if(listSubcategories[currentCol] == undefined) {
          listSubcategories[currentCol] = []
        }
        listSubcategories[currentCol].push(<Subcategory key={category.id} {...category} />);
      }
    });

    return (
      <div>
        <div className="dr-bottom-service">
          <div className="row">
            {listCategories}
          </div>
        </div>
        <div className="profileRefinement">
          <div className="row">
            {listSubcategories.map((subcategories, i) =>
              <div className="col-md-3" key={i}>
                {subcategories}
              </div>
            )}
          </div>
        </div>
      </div>
    );
  }
}

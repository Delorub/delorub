import React from 'react';
import Category from './Category';
import Subcategory from './Subcategory';
import { connect } from 'react-redux'

class Step1 extends React.Component {
  render() {
    const { main_specialization_id } = this.props
    var listCategories = [], listSubcategories = []

    this.props.categories.forEach(function(category) {
      if (category.parent_id == null) {
        listCategories.push(<Category key={category.id} {...category} />);
      }
    });

    var currentCol = 0
    this.props.categories.forEach(function(category) {
      if (category.parent_id == main_specialization_id) {
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
        { main_specialization_id != null &&
          <div className="profileRefinement">
            <input type="hidden" name="main_specialization_id" value={main_specialization_id} />
            <div className="row">
              {listSubcategories.map((subcategories, i) =>
                <div className="col-md-3" key={i}>
                  {subcategories}
                </div>
              )}
            </div>
          </div>
        }
      </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    main_specialization_id: state.$$profileStore.profile.main_specialization_id
  }
}

export default connect(mapStateToProps)(Step1)

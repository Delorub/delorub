import React from 'react';
import classNames from 'classnames'

const renderCategories = ({ label, required, name, subcategories, input, meta}) => {
  var data = []
  var currentCol = 0

  subcategories.forEach(function(category, index) {
    currentCol++
    if(currentCol > 4) {
      currentCol = 1
    }
    if(data[currentCol] == undefined) {
      data[currentCol] = []
    }
    data[currentCol].push(category);
  }, this);

  return (<div>
    <div className="row">
    { data.map((categories, index) => (
      <div className="col-md-3" key={index}>
        { categories.map((category, index2) => (
          <div
            className={classNames({
              ['checkbox']: true,
              ['marked']: input.value.indexOf(category.id) !== -1
            })}
            key={index2}
            >
            <label>
              <input type="checkbox"
                name={`${name}[${category.index}]`}
                value={category.id}
                checked={input.value.indexOf(category.id) !== -1}
                onChange={event => {
                  const newValue = [...input.value];
                  if(event.target.checked) {
                    newValue.push(category.id);
                  } else {
                    newValue.splice(newValue.indexOf(category.id), 1);
                  }
                  return input.onChange(newValue);
                }} />
              {category.title}
            </label>
          </div>
        )) }
      </div>
    )) }
    </div>
    {meta.touched && meta.error &&
     <span className="error">{meta.error}</span>}
  </div>)
}

export default renderCategories;

import React from 'react';

const renderSpecializations = ({ label, required, name, specializations, input, meta}) => {
  var data = []
  var currentCol = 0

  specializations.forEach(function(category, index) {
    currentCol++
    if(currentCol > 4) {
      currentCol = 1
    }
    if(data[currentCol] == undefined) {
      data[currentCol] = []
    }
    category.index = index
    data[currentCol].push(category);
  }, this);

  return (<div>
    <div className="row">
    { data.map((specializations, index) => (
      <div className="col-md-3" key={index}>
        { specializations.map((specialization) => (
          <div className="checkbox" key={specialization.index}>
            <label>
              <input type="checkbox"
                name={`${name}[${specialization.index}]`}
                value={specialization.id}
                checked={input.value.indexOf(specialization.id) !== -1}
                onChange={event => {
                  const newValue = [...input.value];
                  if(event.target.checked) {
                    newValue.push(specialization.id);
                  } else {
                    newValue.splice(newValue.indexOf(specialization.id), 1);
                  }
                  return input.onChange(newValue);
                }}/>
              {specialization.title}
            </label>
          </div>
        )) }
      </div>
    )) }
    </div>
    {meta.touched && meta.error &&
     <span className="error">{meta.error}</span>}
  </div>)
};

export default renderSpecializations;

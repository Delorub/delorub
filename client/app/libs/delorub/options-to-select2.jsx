export const optionsToSelect2 = options => (
  options.map(function(el) {
    return { value: el[1], label: el[0] }
  })
)

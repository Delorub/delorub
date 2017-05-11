export const optionsToSelect2 = options => (
  options.map(function(el) {
    return { id: el[1], text: el[0] }
  })
)

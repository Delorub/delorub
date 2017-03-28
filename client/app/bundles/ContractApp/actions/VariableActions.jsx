export const focusVariable = (id) => ({
  type: 'FOCUS_VARIABLE',
  id: id
})

export const blurVariable = (id) => ({
  type: 'BLUR_VARIABLE',
  id: id
})

export const changeVariable = (id, value) => ({
  type: 'CHANGE_VARIABLE',
  id: id,
  value: value
})

export const errorVariable = (id) => ({
  type: 'ERROR_VARIABLE',
  id: id
})

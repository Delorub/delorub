export const normalizeTime = (value, previousValue) => {
  if (!value) {
    return value
  }
  const onlyNums = value.replace(/[^\d]/g, '')
  if (!previousValue || value.length > previousValue.length) {
    if (onlyNums.length === 2) {
      return onlyNums + ':'
    }
  }
  if (onlyNums.length <= 2) {
    return onlyNums
  }
  return onlyNums.slice(0, 2) + ':' + onlyNums.slice(2, 4)
}

export const normalizePositiveNum = (value, previousValue) => {
  if (!value) {
    return value
  }
  value = value.replace(/[^\d]/g, '')
  value = parseInt(value)
  if(value < 0 || isNaN(value)) {
    value = ''
  }
  return value
}

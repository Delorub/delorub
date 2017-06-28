export const required = value =>
  value ? undefined : 'Обязательно для заполнения'

export const requiredArray = value =>
  value.length > 0 ? undefined : 'Обязательно для заполнения'

export const maxLength = max => value =>
  value && value.length > max ? `Не более ${max} символов` : undefined

export const minLength = min => value =>
  value && value.length < min ? `Не менее ${min} символов` : undefined

export const number = value =>
  value && isNaN(Number(value)) ? 'Должно быть числом' : undefined

export const time = value =>
  value && !/^([0-1]\d|2[0-3]):[0-5][0-9]$/i.test(value) ?
  'Неверный формат времени' : undefined

export const email = value =>
  value && !/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(value) ?
  'Неверный email-адрес' : undefined

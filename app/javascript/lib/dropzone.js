import Dropzone from 'dropzone'

Dropzone.autoDiscover = false
Dropzone.prototype.defaultOptions.dictRemoveFile = 'Удалить'
Dropzone.prototype.defaultOptions.dictCancelUpload = 'Отменить загрузку'
Dropzone.prototype.defaultOptions.dictFileTooBig = 'Фаил слишком большой (максимальный размер файла - {{maxFilesize}} Мб)'
Dropzone.prototype.defaultOptions.dictInvalidFileType = 'Формат файла не поддерживается (поддерживаемые форматы файлов: png, jpg, jpeg, bmp, ttf, doc, pdf, rar, zip, xls)'
Dropzone.prototype.defaultOptions.dictMaxFilesExceeded = 'Превышено максимальное кол-во загружаемых файлов (макс.кол. 4)'
Dropzone.prototype.defaultOptions.dictFileSizeUnits = { tb: 'ТБ', gb: 'ГБ', mb: 'МБ', kb: 'КБ', b: 'б' }

export default Dropzone

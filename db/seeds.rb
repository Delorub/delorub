User.delete_all
Profile.delete_all
Category.delete_all
HelpCategory.delete_all

admins = User.create([
  {
    first_name: 'Алексей',
    last_name: 'Петров',
    password: 'test123123',
    email: 'admin@delorub.com',
    permission_attributes: { superadmin: true },
    confirmed_at: DateTime.current.utc,
    uid: SecureRandom.uuid
  },
  {
    first_name: 'Мария',
    last_name: 'Иванова',
    password: 'test123123',
    email: 'editor@delorub.com',
    permission_attributes: { editor: true },
    confirmed_at: DateTime.current.utc,
    uid: SecureRandom.uuid
  }
])

profile = Profile.create(user_id: admins.first.id, place: Place.only_cities.sample)

categories = Category.create([
  { title: 'Ремонт', photo: File.open('public/images/icons/hammer.png') },
  { title: 'Уборка', photo: File.open('public/images/icons/broom.png') },
  { title: 'Образование', photo: File.open('public/images/icons/cleaner.png') },
  { title: 'Грузоперевозки', photo: File.open('public/images/icons/cargo.png') },
  { title: 'Красота и здоровье', photo: File.open('public/images/icons/pomade.png') },
  { title: 'Вейпинг', photo: File.open('public/images/icons/vape.png') },
  { title: 'Кейтеринг и кулинария', photo: File.open('public/images/icons/cooking.png') },
  { title: 'Спорт и туризм', photo: File.open('public/images/icons/sport.png') },
  { title: 'Интернет-услуги', photo: File.open('public/images/icons/laptop.png') },
  { title: 'Домашний персонал', photo: File.open('public/images/icons/cleaner.png') },
  { title: 'Фото и видеосъемка', photo: File.open('public/images/icons/photo.png') },
  { title: 'Юридическая помощь', photo: File.open('public/images/icons/law.png') },
  { title: 'Уход за животными', photo: File.open('public/images/icons/animal.png') },
  { title: 'Организация мероприятий', photo: File.open('public/images/icons/cocktail.png') },
  { title: 'Тату, пирсинг и бодимодификации', photo: File.open('public/images/icons/horse.png') },
  { title: 'Разное', photo: File.open('public/images/icons/fix.png') }
])

Category.create([
  { title: 'Ремонт автомобилей', parent: categories.first },
  { title: 'Ремонт квартир', parent: categories.first }
])

profile.categories << categories.first
profile.save

help_categories = HelpCategory.create([
  { title: 'Частые вопросы' },
  { title: 'Заказчикам' },
  { title: 'Исполнителям' },
  { title: 'Начало работы' },
  { title: 'Задания' },
  { title: 'Спорные ситуации' },
  { title: 'Финансы' },
  { title: 'Профиль' },
])

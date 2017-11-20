User.delete_all
Profile.delete_all
Category.delete_all
HelpCategory.delete_all
PortfolioItem.delete_all
Comment.delete_all
Certificate.delete_all

### Admins
admins = User.create([
  {
    first_name: 'Алексей',
    last_name: 'Петров',
    password: 'test123123',
    email: 'admin@delorub.com',
    permission_attributes: { superadmin: true },
    place: Place.only_cities.sample
  }
])

### Profiles
profile = Profile.create(user_id: admins.first.id)
=begin
### Categories
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
=end

categories = Category.create([
  { title: 'Ремонт' },
  { title: 'Уборка' },
  { title: 'Образование' },
  { title: 'Грузоперевозки' },
  { title: 'Красота и здоровье'},
  { title: 'Вейпинг' },
  { title: 'Кейтеринг и кулинария' },
  { title: 'Спорт и туризм'},
  { title: 'Интернет-услуги' },
  { title: 'Домашний персонал' },
  { title: 'Фото и видеосъемка' },
  { title: 'Юридическая помощь' },
  { title: 'Уход за животными' },
  { title: 'Организация мероприятий' },
  { title: 'Тату, пирсинг и бодимодификации' },
  { title: 'Разное'}
])

Category.create([
  { title: 'Ремонт автомобилей', parent: categories.first },
  { title: 'Ремонт квартир', parent: categories.first }
])

profile.categories << categories.first
profile.save

### HelpCategories
HelpCategory.create([
  { title: 'Частые вопросы' },
  { title: 'Заказчикам' },
  { title: 'Исполнителям' },
  { title: 'Начало работы' },
  { title: 'Задания' },
  { title: 'Спорные ситуации' },
  { title: 'Финансы' },
  { title: 'Профиль' },
])

### PortfolioItems
portfolio_item = profile.portfolio_items.create(file: File.open(File.join(Rails.root, 'spec', 'support', 'portfolio_item', 'files', 'image.png')))

### Comments
portfolio_item.comments.create(user: admins.sample, text: Faker::Lorem.sentence(10))

### Certificates
profile.certificates.create(file: File.open(File.join(Rails.root, 'spec', 'support', 'certificate', 'files', 'image.png')))


Category.all.each do |category|
  array_title = ['ванну', 'туалет', 'что-то']
  category.tasks.create(
    title: "Сделать #{array_title.sample}",
    description: 'СБ ООН принял 5 августа новую резолюцию, предусматривающую ограничения импорта угля, железной руды и морепродуктов из КНДР, после двух испытаний в июле баллистических ракет, которые, как утверждают в Пхеньяне, могут долететь до территории США. По подсчетам американцев, полное выполнение санкций против КНДР позволит сократить ежегодные валютные доходы Пхеньяна, составляющие сейчас около 3 миллиардов долларов, на треть.',
    user_id: [7, 8].sample, price_type: 'exact', date_type: 'end_at'
  )
end

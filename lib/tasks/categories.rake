namespace :categories do

  # rake categories:create_tasks
=begin
  namespace :create_tasks do
    Category.all.each do |category|
      array_title = ['ванну', 'туалет', 'что-то']
      category.tasks.create(
        title: "Сделать #{array_title.sample}",
        description: 'СБ ООН принял 5 августа новую резолюцию, предусматривающую ограничения импорта угля, железной руды и морепродуктов из КНДР, после двух испытаний в июле баллистических ракет, которые, как утверждают в Пхеньяне, могут долететь до территории США. По подсчетам американцев, полное выполнение санкций против КНДР позволит сократить ежегодные валютные доходы Пхеньяна, составляющие сейчас около 3 миллиардов долларов, на треть.',
        user_id: [7, 8].sample, price_type: 'exact', date_type: 'end_at'
      )
    end
  end
=end
end

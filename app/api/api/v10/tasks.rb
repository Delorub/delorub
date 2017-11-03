class Api::V10::Tasks < ApplicationAPI
  namespace :tasks do
    namespace :files do
      desc 'Upload a new file'
      params do
        requires :file, type: File, desc: 'File'
      end
      post do
        present TaskFile.create!(file: params[:file]), with: Entities::TaskFile
      end
    end

    namespace :order do
      desc 'Order task by params'
      post do
        data = params['query']
        result = TaskQuery.new(collection: Task.all,
                               category: Category.friendly.find_by(slug: data[:category_id]),
                               page: data[:page],
                               direction_created: data[:direction_created],
                               place: Place.only_cities.friendly.find_by(slug: data[:city_code])).perform

        present result, with: Entities::Task
      end
    end
  end
end

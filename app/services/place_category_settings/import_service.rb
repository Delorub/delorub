class PlaceCategorySettings::ImportService
  attr_reader :file, :type, :category, :city

  def initialize file:, type:, category:, city:
    @city = city
    @file = file
    @category = category
    @type = type
  end

  def perform
    (package.first_row + 1..package.last_row).each do |number|
      parse_row package.row(number)
    end
  end

  private

    def package
      raise "File can't be blank" if file.blank?

      @package ||= case File.extname(file.original_filename)
                     when '.xls' then Roo::Excel.new(file.path)
                     when '.xlsx' then Roo::Excelx.new(file.path)
                     else raise "Unknown file type: #{file.original_filename}"
                   end
    end

    def parse_row value
      sub_category = category.self_and_descendants.where(title: value[0]).first
      return if sub_category.blank?

      setting = find_setting sub_category
      setting.settings = RecursiveOpenStruct.new(settings_value(value), recurse_over_arrays: true)
      setting.save
    end

    def settings_value value
      { h1: value[1].to_s, seo_title: value[2].to_s, seo_keywords: value[3].to_s, seo_description: value[4].to_s }
    end

    def find_setting sub_category
      setting = city.categories_settings.where(category_id: sub_category.id, settings_type: type).first
      if setting.blank?
        setting = city.categories_settings.create(category_id: sub_category.id, settings_type: type)
      end
      setting
    end
end

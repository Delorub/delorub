class Category::ExternalDataSettings::Export
  attr_reader :contents

  def perform
    categories.find_each do |category|
      category_sheet category
    end

    file = Tempfile.new('category_external_data_settings_export')
    begin
      package.serialize file
      @contents = File.read file
    ensure
      file.close
      file.unlink
    end
  end

  def package
    @_package ||= Axlsx::Package.new
  end

  private

    def category_sheet category
      workbook.add_worksheet(name: sheet_title(category)) do |sheet|
        sheet.add_row [category.id, category_full_title(category)]

        length = [category.external_data_settings.words.try(:size), category.external_data_settings.stopwords.try(:size)].max || 0

        length.times do |i|
          sheet.add_row [category.external_data_settings.words[i], category.external_data_settings.stopwords[i]]
        end
      end
    end

    def category_full_title category
      category.self_and_ancestors.map(&:title).join(' > ')
    end

    def sheet_title category
      category.title[0..26] + ' ' + category.id.to_s
    end

    def categories
      Category
    end

    def workbook
      package.workbook
    end
end

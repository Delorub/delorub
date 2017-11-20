class PlaceCategorySettings::ExportService
  ROWS = [:h1, :seo_title, :seo_keywords, :seo_description].freeze

  attr_reader :city, :category, :type

  def initialize city:, category:, type:
    @city = city
    @category = category
    @type = type
  end

  def perform
    apply_title
    apply_rows

    file = Tempfile.new('category_settings')
    begin
      package.serialize file
      File.read file
    ensure
      file.close
      file.unlink
    end
  end

  def name
    format('%s %s %s.xlsx', city.name, category.title, type)
  end

  private

    def package
      @_package ||= Axlsx::Package.new
    end

    def workbook
      @_workbook ||= package.workbook.add_worksheet(name: 'Настройка SEO')
    end

    def apply_title
      workbook.add_row ['Категория', 'H1', 'Seo Title', 'Seo KeyWords', 'Seo Description'], style: title_style
    end

    def apply_rows
      category.self_and_descendants.order(:title).each do |category|
        setting = city.categories_settings.where(category_id: category.id, settings_type: type).first
        workbook.add_row row_value(category, setting), style: row_style, height: height_row(setting)
      end

      workbook.column_widths 25, 35, 35, 50, 50
    end

    def row_value category, setting
      ROWS.map{ |key| setting_value(setting, key) }.unshift category.title
    end

    def setting_value setting, key
      setting.present? ? setting.settings.dig(key) : ''
    end

    def title_style
      workbook.styles.add_style(bg_color: 'A9A9A9', sz: 14,
                                border: { style: :thin, color: '000000' },
                                alignment: { horizontal: :center, vertical: :center })
    end

    def row_style
      workbook.styles.add_style alignment: { wrap_text: true, horizontal: :center, vertical: :center }
    end

    def height_row setting
      count_row = 1
      ROWS.each do |key|
        length_value = setting_value(setting, key).length

        new_count = %w[h1 seo_title].include?(key) ? length_value / 35 : length_value / 45
        count_row = new_count if count_row < new_count
      end
      count_row > 1 ? count_row * 13 : count_row * 20
    end
end

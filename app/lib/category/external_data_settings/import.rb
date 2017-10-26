class Category::ExternalDataSettings::Import
  attr_reader :file

  def initialize file
    @file = file
  end

  def perform
    package.each_with_pagename do |name, sheet|
      process_sheet sheet
    end

    ExternalData::FilterAllWorker.perform_async
  end

  private

    def process_sheet sheet
      category = Category.find_by id: sheet.cell(1, 1)
      return if category.nil?

      category.external_data_settings.words = fetch_column(sheet, 1)
      category.external_data_settings.stopwords = fetch_column(sheet, 2)
      category.save
    end

    def fetch_column sheet, column_number
      sheet.column(column_number)[1..-1].map { |e| process_word(e) }.compact
    end

    def process_word word
      return if word.nil?
      word = word.to_s
      word = word.strip
      word = word.downcase
      word = word.gsub(/\s+/, ' ')
      return if word.blank?
      word
    end

    def package
      @package ||= Roo::Spreadsheet.open(@file)
    end
end

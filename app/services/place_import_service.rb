class PlaceImportService
  attr_reader :seed_development, :places_levels

  def initialize seed_development: false
    @seed_development = seed_development
    @places_levels = {}
  end

  def perform
    import_type_names
    import_places
  end

  private

    def import_type_name row
      PlaceTypeName.create!(
        id: row[:place_type_name_id],
        level: row[:level],
        code: row[:code],
        name: row[:name],
        full_name: row[:full_name],
        alt_name: row[:alt_name],
        after_place_name: row[:after_place_name]
      )
    end

    def import_type_names
      csv_text = File.read('public/geo/place_type_names.csv')
      csv = CSV.parse(csv_text, headers: true, col_sep: ';')
      csv.each do |row|
        row = row.to_hash.symbolize_keys
        next if PlaceTypeName.exists? row[:place_type_name_id].to_i
        import_type_name row
      end
    end

    def should_import_place? row
      if seed_development
        places_levels[row[:level]] = 0 if places_levels[row[:level]].nil?
        places_levels[row[:level]] += 1
        return false if places_levels[row[:level]] >= 100
      end
      return false if Place.exists? row[:place_id].to_i
      true
    end

    def import_place row
      Place.create(
        id: row[:place_id],
        fias_aoguid: row[:fias_aoguid],
        name: row[:name],
        custom: row[:custom],
        parent_place_id: row[:parent_place_id],
        region_place_id: row[:region_place_id],
        is_region_center: row[:is_region_center],
        is_center: row[:is_center],
        level: row[:level],
        place_type: row[:type],
        place_type_name_id: row[:place_type_name_id]
      )
    end

    def import_places
      ['public/geo/regions.csv', 'public/geo/places.csv', 'public/geo/streets.csv'].each do |name|
        csv_text = File.read(name)
        csv = CSV.parse(csv_text, headers: true, col_sep: ';')
        csv.each do |row|
          row = row.to_hash.symbolize_keys
          next unless should_import_place? row
          import_place row
        end
      end
    end
end

namespace :geo do
  desc 'Import geo data from CSV'
  task import: :environment do
    require 'csv'

    csv_text = File.read('public/geo/place_type_names.csv')
    csv = CSV.parse(csv_text, headers: true, col_sep: ';')
    csv.each do |row|
      row = row.to_hash.symbolize_keys
      next if PlaceTypeName.find_by :id, row[:place_type_name_id]
      PlaceTypeName.create(
        id: row[:place_type_name_id],
        level: row[:level],
        code: row[:code],
        name: row[:name],
        full_name: row[:full_name],
        alt_name: row[:alt_name],
        after_place_name: row[:after_place_name]
      )
    end

    ['public/geo/regions.csv', 'public/geo/places.csv', 'public/geo/streets.csv'].each do |name|
      csv_text = File.read(name)
      csv = CSV.parse(csv_text, headers: true, col_sep: ';')
      csv.each do |row|
        row = row.to_hash.symbolize_keys
        next if Place.find_by :id, row[:place_id]
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
        p '1'
      end
    end
  end
end

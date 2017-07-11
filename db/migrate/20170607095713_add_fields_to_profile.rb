class AddFieldsToProfile < ActiveRecord::Migration[4.2]
  def change
    remove_column :profiles, :place_address, :string
    remove_column :profiles, :place_lat, :float
    remove_column :profiles, :place_long, :float
    remove_column :profiles, :pay_type, :string
    remove_column :profiles, :have_truck, :boolean

    add_column :profiles, :price_type, :string
    add_column :profiles, :price_hourly, :integer
    add_column :profiles, :price_project, :integer

    add_column :profiles, :have_instrument, :boolean, default: false
    add_column :profiles, :can_departure, :boolean, default: false

    add_column :profiles, :working_all_time, :boolean, default: false
    add_column :profiles, :working_days, :string
    add_column :profiles, :working_hours_from, :integer
    add_column :profiles, :working_hours_to, :integer

    add_column :profiles, :rating_votes_count, :integer
    add_column :profiles, :rating_votes_sum, :integer
    add_column :profiles, :rating, :float

    add_column :profiles, :notifications_email_enabled, :boolean, default: true
  end
end

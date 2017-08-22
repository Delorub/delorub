class ChangeProfileFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :working_all_time, :boolean
    remove_column :profiles, :working_days, :string
    remove_column :profiles, :working_hours_from, :integer
    remove_column :profiles, :working_hours_to, :integer
    remove_column :profiles, :work_type, :string
    remove_column :profiles, :have_car, :boolean
    remove_column :profiles, :have_instrument, :boolean
    remove_column :profiles, :can_departure, :boolean
    remove_column :profiles, :price_type, :string
    remove_column :profiles, :price_hourly, :integer
    remove_column :profiles, :notifications_email_enabled, :boolean
    add_column :profiles, :birthday, :date
    add_column :profiles, :city_name, :string
  end
end

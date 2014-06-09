class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.date :date
      t.string :title
      t.string :description
    end
  end
end

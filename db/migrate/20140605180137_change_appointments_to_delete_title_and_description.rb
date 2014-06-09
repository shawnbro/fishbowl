class ChangeAppointmentsToDeleteTitleAndDescription < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
      t.remove :title 
      t.remove :description
    end
  end
end

class ChangeAppointments < ActiveRecord::Migration
  def change
    change_table(:appointments) do |t|
      t.belongs_to :user
    end
  end
end

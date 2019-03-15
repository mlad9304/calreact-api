class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :appt_time
    end
  end
end

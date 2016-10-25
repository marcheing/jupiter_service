class CreateSchedule < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :day
      t.string :start_time
      t.string :end_time
      t.references :professor
      t.timestamps
    end
  end
end

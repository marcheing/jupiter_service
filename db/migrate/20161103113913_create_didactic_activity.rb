class CreateDidacticActivity < ActiveRecord::Migration[5.0]
  def change
    create_table :didactic_activities do |t|
      t.integer :workload_hours
      t.string :activity_type
      t.references :professor
      t.timestamps
    end
  end
end

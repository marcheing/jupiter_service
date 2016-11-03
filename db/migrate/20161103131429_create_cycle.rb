class CreateCycle < ActiveRecord::Migration[5.0]
  def change
    create_table :cycles do |t|
      t.string :name
      t.string :period
      t.integer :codcur
      t.integer :codhab
      t.date :start_date
      t.string :ideal_duration
      t.string :minimum_duration
      t.string :maximum_duration
      t.text :specific_information
      t.text :observations
      t.timestamps
    end

    change_table :workloads do |t|
      t.references :cycle
    end
  end
end

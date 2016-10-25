class CreateWorkload < ActiveRecord::Migration[5.0]
  def change
    create_table :workloads do |t|
      t.text :mandatory
      t.text :optional
      t.text :elective
      t.text :total
      t.timestamps
    end
  end
end

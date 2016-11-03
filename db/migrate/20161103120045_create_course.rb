class CreateCourse < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.string :alt_name
      t.string :faculty
      t.string :department
      t.text :workload
      t.string :period
      t.date :activation_date
      t.text :goals
      t.text :short_syllabus
      t.text :short_syllabus
      t.text :evaluation
      t.text :bibliography
      t.timestamps
    end
  end
end

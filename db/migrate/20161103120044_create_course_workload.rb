class CreateCourseWorkload < ActiveRecord::Migration[5.0]
  def change
    create_table :course_workloads do |t|
      t.integer :class_credits
      t.integer :work_credits
      t.integer :total
      t.references :course
      t.timestamps
    end
  end
end

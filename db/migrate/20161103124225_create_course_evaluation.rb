class CreateCourseEvaluation < ActiveRecord::Migration[5.0]
  def change
    create_table :course_evaluations do |t|
      t.string :method
      t.string :criterion
      t.string :rec
      t.references :course
      t.timestamps
    end
  end
end

class CreateCoursesProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_professors do |t|
      t.integer :course_id, null: false
      t.integer :professor_id, null: false
    end
  end
end

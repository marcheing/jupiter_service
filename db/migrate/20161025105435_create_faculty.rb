class CreateFaculty < ActiveRecord::Migration[5.0]
  def change
    create_table :faculties do |t|
      t.integer :code, null: false
      t.string :name
      t.string :campus
      t.timestamps
    end
  end
end

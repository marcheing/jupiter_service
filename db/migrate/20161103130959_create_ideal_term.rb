class CreateIdealTerm < ActiveRecord::Migration[5.0]
  def change
    create_table :ideal_terms do |t|
      t.references :course, null: false
      t.references :cycle, null: false
      t.string :category, null: false
      t.string :term, null: false
      t.timestamps
    end
  end
end

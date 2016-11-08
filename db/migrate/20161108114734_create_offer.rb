class CreateOffer < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.references :course, null: false
      t.date :start_date
      t.date :end_date
      t.string :class_type
      t.string :class_code
      t.text :observations
      t.timestamps
    end

    change_table :didactic_activities do |t|
      t.references :offer
    end

    change_table :schedules do |t|
      t.references :offer
    end

    change_table :subscriptions do |t|
      t.references :offer
    end
  end
end

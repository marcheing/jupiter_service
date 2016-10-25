class CreateSubscription < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :kind
      t.string :assigned_to
      t.integer :vacancy
      t.integer :subscribed
      t.integer :pending
      t.integer :enrolled
      t.timestamps
    end
  end
end

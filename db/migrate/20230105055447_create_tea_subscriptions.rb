class CreateTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :tea_subscriptions do |t|
      t.references :subscriptions, foreign_key: true
      t.references :teas, foreign_key: true
      t.timestamps
    end
  end
end

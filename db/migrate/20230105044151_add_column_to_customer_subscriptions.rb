class AddColumnToCustomerSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_subscriptions, :status, :string
  end
end

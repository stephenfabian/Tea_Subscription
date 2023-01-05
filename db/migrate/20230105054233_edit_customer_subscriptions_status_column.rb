class EditCustomerSubscriptionsStatusColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :customer_subscriptions, :status, :string, default: "active"
  end
end

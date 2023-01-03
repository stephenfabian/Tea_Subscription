class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
end
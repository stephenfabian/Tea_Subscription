class Subscription < ApplicationRecord
  validates_presence_of :title, :price
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end
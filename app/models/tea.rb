class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temperature, :brew_time
  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
end
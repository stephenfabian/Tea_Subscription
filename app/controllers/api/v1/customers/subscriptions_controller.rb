class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    if Customer.exists?(params[:customer_id])
      customer = Customer.find(params[:customer_id])
      customers_subscriptions = customer.subscriptions
      render json: SubscriptionsSerializer.new(customers_subscriptions)
    else
      render json: {"data": {}}, status: 404 
    end
  end
end

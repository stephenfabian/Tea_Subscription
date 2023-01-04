class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(cust_subscription_params)
    if customer_subscription.save
      render json: CustomerSubscriptionSerializer.new(customer_subscription)
    else
      render json: {"data": {}}, status: 400
    end
  end

  # def destroy
  #   render json: CustomerSubscription.destroy(params[:id])  
  # end

  private

  def cust_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end
end

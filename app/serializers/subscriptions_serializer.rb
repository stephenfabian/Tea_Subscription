class SubscriptionsSerializer
  include JSONAPI::Serializer

  def initialize(objects, params)
    @objects = objects
    @params = params
  end

  def status_of_subscription(subscription)
    customer_subscription = CustomerSubscription.where(customer_id: @params[:customer_id], subscription_id: subscription.id).first
    customer_subscription.status
  end

  def add_status_to_response
   {
      data: @objects.map do |subscription|
        {
          type: 'subscriptions',
          id: subscription.id,
          attributes: {
            title: subscription.title,
            price: subscription.price,
            status: status_of_subscription(subscription)
          }
        }
      end
    }
  end
end

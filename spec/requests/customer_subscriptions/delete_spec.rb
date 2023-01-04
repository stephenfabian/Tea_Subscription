require 'rails_helper'

RSpec.describe 'Customer Subscription Destroy Request Feature' do
  describe 'DELETE - api/v1/customer_subscriptions#destroy' do
    let!(:customer) {Customer.create!(first_name: "Stephen", last_name: "Fabian", email: "fabianstephen@gmail.com", address: "1882 Blue Ct, Denver CO 80654")}
    let!(:subscription) {customer.subscriptions.create!(title: "Cheap Subscription", price: 5, status: "active")}
    let!(:customer_subscription) {customer.customer_subscriptions.first}

    it 'can delete a customer subscription' do
      expect(CustomerSubscription.all.count).to eq(1)
      delete "/api/v1/customer_subscriptions/#{customer_subscription.id}"

      expect(response).to be_successful
      expect(CustomerSubscription.all.count).to eq(0)
    end
    
    it 'response has correct formatting' do 
      delete "/api/v1/customer_subscriptions/#{customer_subscription.id}"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key(:id)
      expect(parsed_response[:customer_id]).to eq(customer.id)
      expect(parsed_response[:subscription_id]).to eq(subscription.id)
    end

    it 'sad path - if customer subscription doesnt exist, return status 404' do
      delete "/api/v1/customer_subscriptions/#{9999999}"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parsed_response[:data]).to eq({})
    end
  end
end
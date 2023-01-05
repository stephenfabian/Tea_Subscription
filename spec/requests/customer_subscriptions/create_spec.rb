require 'rails_helper'

RSpec.describe 'User Story 1 - Customer Subscription Create' do
    let(:customer) {Customer.create!(first_name: "Stephen", last_name: "Fabian", email: "fabianstephen@gmail.com", address: "1882 Blue Ct, Denver CO 80654")}
    let(:subscription) {Subscription.create!(title: "Cheap Subscription", price: 5)}

  describe 'POST - /api/v1/customer_subscriptions/create' do
    it 'can create a customer subscription' do
      params = ({customer_id: customer.id, subscription_id: subscription.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      post api_v1_customer_subscriptions_path, headers: headers, params: JSON.generate(customer_subscription: params)
      created_cust_subscription = CustomerSubscription.last

      expect(response).to be_successful
      expect(created_cust_subscription.customer_id).to eq(params[:customer_id])
      expect(created_cust_subscription.subscription_id).to eq(params[:subscription_id])
    end

    it 'response is formatted correctly' do
      params = ({customer_id: customer.id, subscription_id: subscription.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      post api_v1_customer_subscriptions_path, headers: headers, params: JSON.generate(customer_subscription: params)
      created_cust_subscription = CustomerSubscription.last
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to eq(created_cust_subscription.id.to_s)
      expect(parsed_response[:data][:type]).to eq("customer_subscription")
      expect(parsed_response[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(parsed_response[:data][:attributes][:subscription_id]).to eq(subscription.id)
    end

    it 'sad path - missing params returns error message' do
      params = ({customer_id: customer.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      post api_v1_customer_subscriptions_path, headers: headers, params: JSON.generate(customer_subscription: params)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(400)
      expect(parsed_response[:data]).to eq({})
    end
  end
end
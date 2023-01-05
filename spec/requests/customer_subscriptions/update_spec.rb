require 'rails_helper'

RSpec.describe 'Customer Subscription Destroy Request Feature' do
  describe 'PATCH - api/v1/customer_subscriptions#update' do
    let!(:customer) {Customer.create!(first_name: "Stephen", last_name: "Fabian", email: "fabianstephen@gmail.com", address: "1882 Blue Ct, Denver CO 80654")}
    let!(:subscription) {customer.subscriptions.create!(title: "Cheap Subscription", price: 5)}
    let!(:customer_subscription) {customer.customer_subscriptions.first}

    it 'can update a customer subscriptions status to active or cancelled' do
      params = ({status: "active"})
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/customer_subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate(customer_subscription: params)

      expect(response).to be_successful
      expect(customer_subscription.reload.status).to eq(params[:status])
    end
    
    it 'response has correct formatting' do 
      params = ({status: "active"})
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/customer_subscriptions/#{customer_subscription.id}", headers: headers, params: JSON.generate(customer_subscription: params)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][:id]).to eq(customer_subscription.id.to_s)
      expect(parsed_response[:data][:type]).to eq("customer_subscription")
      expect(parsed_response[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(parsed_response[:data][:attributes][:subscription_id]).to eq(subscription.id)
      expect(parsed_response[:data][:attributes][:status]).to eq(params[:status])
    end

    it 'sad path - if customer subscription doesnt exist, return status 404' do
      patch "/api/v1/customer_subscriptions/#{9999999}"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parsed_response[:data]).to eq({})
    end
  end
end
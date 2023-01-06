require 'rails_helper' 

RSpec.describe 'Customers Subscriptions Index' do
  describe 'GET - /api/v1/customers/:customer_id/subscriptions' do
    let!(:customer1) {Customer.create!(first_name: "Stephen", last_name: "Fabian", email: "fabianstephen@gmail.com", address: "1882 Blue Ct, Denver CO 80654")}
    let!(:customer2) {Customer.create!(first_name: "Tommy", last_name: "Jones", email: "fabiant@gmail.com", address: "1111 Blue Ct, Denver CO 80654")}
    let!(:subscription1) {customer1.subscriptions.create!(title: "Cheap Subscription", price: 5)}
    let!(:subscription2) {customer1.subscriptions.create!(title: "Premium Subscription", price: 50)}
    let!(:subscription3) {customer2.subscriptions.create!(title: "Medium Subscription", price: 20)}
    let!(:customer_subscription1) {customer1.customer_subscriptions.first}
    let!(:customer_subscription2) {customer1.customer_subscriptions.second}
    let!(:customer_subscription3) {customer2.customer_subscriptions.first}

    it 'can show all of a given customers subscriptions, and doesnt includs other customers subscriptions' do
      expect(customer1.subscriptions).to eq([subscription1, subscription2])
      get "/api/v1/customers/#{customer1.id}/subscriptions"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      parsed_response[:data].each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscriptions")
        expect(subscription[:attributes]).to have_key(:title)
        expect(subscription[:attributes]).to have_key(:price)
      end

      expect(parsed_response[:data].first[:id]).to eq(subscription1.id)
      expect(parsed_response[:data].second[:id]).to eq(subscription2.id)
      expect(parsed_response[:data].count).to eq(2)
    end

    it 'sad path - if customer doesnt exist, return status 404' do
      get "/api/v1/customers/#{999999}/subscriptions"
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(404)
      expect(parsed_response[:data]).to eq({})
    end
  end
end
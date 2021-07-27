require 'rails_helper'

RSpec.describe "front::V1::Products", type: :request do
  let(:employe) { create(:employe) }

  context "GET /products" do
    let(:url) { "/front/v1/products" }
    let!(:categories) { create(:category) }
    let!(:products) { create_list(:product, 10, category: categories) }

    it "returns all Products" do
      get url, headers: auth_header(employe)
      expect(body_json['products'].count).to eq Product.all.count
    end

    it "returns success status" do
      get url, headers: auth_header(employe)
      expect(response).to have_http_status(:ok)
    end
  end

  context "GET /products/:id" do
    let(:product) { create(:product) }
    let(:url) { "/admin/v1/products/#{product.id}" }

    it "returns requested Product" do
      get url, headers: auth_header(employe)

      expect(body_json['product']['id']).to eq product.id
      expect(body_json['product']['name']).to eq product.name
      expect(body_json['product']['description']).to eq product.description
    end

    it "returns success status" do
      get url, headers: auth_header(employe)
      expect(response).to have_http_status(:ok)
    end
  end

  context "with search[name] param" do
    let(:url) { "/front/v1/products" }

    let!(:search_name_products) do
      products = [] 
      15.times { |n| products << create(:product, name: "Search #{n + 1}") }
      products 
    end

    let(:search_params) { { search: { name: "Search" } } }

    it "returns only seached products limited by default pagination" do
      get url, headers: auth_header(employe), params: search_params
      expected_return = search_name_products[0..9]
      expect(body_json['products'].count).to eq expected_return.count
    end

    it "returns success status" do
      get url, headers: auth_header(employe), params: search_params
      expect(response).to have_http_status(:ok)
    end
  end
    
end

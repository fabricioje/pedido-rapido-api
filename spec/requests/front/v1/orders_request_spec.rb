require "rails_helper"

RSpec.describe "front::V1::Orders", type: :request do
  context "Waiter context" do
    let(:employee) { create(:employee, occupation: :waiter) }

    context "POST /orders" do
      let(:url) { "/front/v1/orders" }

      context "with valid params" do
        let!(:product_list) { create_list(:product, 5) }

        let(:order_params) do
          order = attributes_for(:order)
          order[:employee_id] = employee.id
          order[:order_items] = []
          product_list.each do |product|
            order[:order_items] << attributes_for(:order_item, product_id: product.id)
          end
          { order: order }.to_json
        end

        it "adds a new Order" do
          expect do
            post url, headers: auth_header(employee), params: order_params
          end.to change(Order, :count).by(1)
        end

        it "returns last added Order" do
          post url, headers: auth_header(employee), params: order_params
          expected_order = Order.last
          expect(body_json["order"]["id"]).to eq expected_order.id
        end

        it "returns success status" do
          post url, headers: auth_header(employee), params: order_params
          expect(response).to have_http_status(:ok)
        end
      end

      context "with invalid params" do
        let(:order_invalid_params) do
          { order: attributes_for(:order, name: nil) }.to_json
        end

        let!(:product_list) { create_list(:product, 5) }

        let(:order_invalid_params) do
          order = attributes_for(:order)
          order[:name] = nil
          order[:employee_id] = nil
          order[:order_items] = []
          product_list.each do |product|
            order[:order_items] << attributes_for(:order_item, product_id: product.id)
          end
          { order: order }.to_json
        end

        it "does not add a new Order" do
          expect do
            post url, headers: auth_header(employee), params: order_invalid_params
          end.to_not change(Order, :count)
        end

        it "returns error message" do
          post url, headers: auth_header(employee), params: order_invalid_params
          expect(body_json["errors"]["fields"]).to have_key("name")
          expect(body_json["errors"]["fields"]).to have_key("employee")
        end

        it "returns unprocessable_entity status" do
          post url, headers: auth_header(employee), params: order_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "GET /orders" do
      let(:url) { "/front/v1/orders" }

      let!(:orders) { create_list(:order, 10, :with_items) }

      it "returns all Orders" do
        get url, headers: auth_header(employee)
        expect(body_json["orders"].count).to eq Order.all.count
      end

      it "returns success status" do
        get url, headers: auth_header(employee)
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders with search[name] param" do
      let(:url) { "/front/v1/orders" }
      let!(:orders_list) { create_list(:order, 10, name: "Customer name") }

      let!(:search_name_orders) do
        orders = []
        15.times { |n| orders << create(:order, name: "Search #{n + 1}", table_number: n + 1) }
        orders
      end

      let(:search_name_params) { { search: { name: "Search" } } }

      it "returns only seached orders limited by default pagination" do
        get url, headers: auth_header(employee), params: search_name_params
        expected_return = search_name_orders[0..9]
        expect(body_json["orders"].count).to eq expected_return.count
      end

      it "returns success status" do
        get url, headers: auth_header(employee), params: search_name_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders with search[table_number] param" do
      let(:url) { "/front/v1/orders" }
      let!(:orders_list) { create_list(:order, 10, name: "Customer name") }
      let!(:expected_order) { create(:order, name: "My Order", table_number: 11) }

      let(:search_table_number_params) { { search: { table_number: 11 } } }

      it "returns only seached orders limited by default pagination" do
        get url, headers: auth_header(employee), params: search_table_number_params
        expect(body_json["orders"].count).to eq 1
        expect(body_json["orders"].first["id"]).to eq expected_order.id
        expect(body_json["orders"].first["table_number"]).to eq expected_order.table_number
      end

      it "returns success status" do
        get url, headers: auth_header(employee), params: search_table_number_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders/:id" do
      let(:order) { create(:order, :with_items, employee: employee) }
      let(:url) { "/front/v1/orders/#{order.id}" }

      it "returns requested Order" do
        get url, headers: auth_header(employee)

        expect(body_json["order"]["id"]).to eq order.id
        expect(body_json["order"]["table_number"]).to eq order.table_number
        expect(body_json["order"]["name"]).to eq order.name
        expect(body_json["order"]["ordem_items"].count).to eq order.order_items.size
      end

      it "returns success status" do
        get url, headers: auth_header(employee)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context "Cooker context" do
    let(:employee) { create(:employee, occupation: :cooker) }

    context "GET /orders" do
      let(:url) { "/front/v1/orders" }

      let!(:orders) { create_list(:order, 10, :with_items) }

      it "returns all Orders" do
        get url, headers: auth_header(employee)
        expect(body_json["orders"].count).to eq Order.all.count
      end

      it "returns success status" do
        get url, headers: auth_header(employee)
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders with search[name] param" do
      let(:url) { "/front/v1/orders" }
      let!(:orders_list) { create_list(:order, 10, name: "Customer name") }

      let!(:search_name_orders) do
        orders = []
        15.times { |n| orders << create(:order, name: "Search #{n + 1}", table_number: n + 1) }
        orders
      end

      let(:search_name_params) { { search: { name: "Search" } } }

      it "returns only seached orders limited by default pagination" do
        get url, headers: auth_header(employee), params: search_name_params
        expected_return = search_name_orders[0..9]
        expect(body_json["orders"].count).to eq expected_return.count
      end

      it "returns success status" do
        get url, headers: auth_header(employee), params: search_name_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders with search[table_number] param" do
      let(:url) { "/front/v1/orders" }
      let!(:orders_list) { create_list(:order, 10, name: "Customer name") }
      let!(:expected_order) { create(:order, name: "My Order", table_number: 11) }

      let(:search_table_number_params) { { search: { table_number: 11 } } }

      it "returns only seached orders limited by default pagination" do
        get url, headers: auth_header(employee), params: search_table_number_params
        expect(body_json["orders"].count).to eq 1
        expect(body_json["orders"].first["id"]).to eq expected_order.id
        expect(body_json["orders"].first["table_number"]).to eq expected_order.table_number
      end

      it "returns success status" do
        get url, headers: auth_header(employee), params: search_table_number_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET /orders/:id" do
      let(:order) { create(:order, :with_items, employee: employee) }
      let(:url) { "/front/v1/orders/#{order.id}" }

      it "returns requested Order" do
        get url, headers: auth_header(employee)

        expect(body_json["order"]["id"]).to eq order.id
        expect(body_json["order"]["table_number"]).to eq order.table_number
        expect(body_json["order"]["name"]).to eq order.name
        expect(body_json["order"]["ordem_items"].count).to eq order.order_items.size
      end

      it "returns success status" do
        get url, headers: auth_header(employee)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end

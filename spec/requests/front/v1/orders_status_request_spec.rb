require "rails_helper"

RSpec.describe "front::V1::Orders::Status", type: :request do
  context "Update status Order" do
    let(:employee) { create(:employee, occupation: :waiter) }

    context "PATCH /orders/:id/status" do
      let!(:order) { create(:order, :with_items) }

      context "with valid status" do
        context "complete order" do
          let!(:status) { "completed" }
          let(:url) { "/front/v1/orders/#{order.id}/status/#{status}" }

          it "updates order status" do
            patch url, headers: auth_header(employee)
            expect(body_json["order"]["id"]).to eq order.id
            expect(body_json["order"]["status"]).to eq status
          end

          it "returns success status" do
            patch url, headers: auth_header(employee)
            expect(response).to have_http_status(:ok)
          end
        end

        context "cancel order" do
          let!(:status) { "canceled" }
          let(:url) { "/front/v1/orders/#{order.id}/status/#{status}" }

          it "updates order status" do
            patch url, headers: auth_header(employee)
            expect(body_json["order"]["id"]).to eq order.id
            expect(body_json["order"]["status"]).to eq status
          end

          it "returns success status" do
            patch url, headers: auth_header(employee)
            expect(response).to have_http_status(:ok)
          end
        end
      end

      context "with invalid status" do
        let(:status_invalid) { "test" }
        let(:url) { "/front/v1/orders/#{order.id}/status/#{status_invalid}" }

        it "does not updates order status" do
          patch url, headers: auth_header(employee)
          expect(order.status).to eq Order.find(order.id).status
        end

        it "returns error message" do
          patch url, headers: auth_header(employee)
          expect(body_json["errors"]["fields"]).to have_key("status")
        end

        it "returns unprocessable_entity status" do
          patch url, headers: auth_header(employee)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context "with empty status" do
        let(:status_invalid) { "test" }
        let(:url) { "/front/v1/orders/#{order.id}/status/#{status_invalid}" }

        it "does not updates order status" do
          patch url, headers: auth_header(employee)
          expect(order.status).to eq Order.find(order.id).status
        end

        it "returns error message" do
          patch url, headers: auth_header(employee)
          expect(body_json["errors"]["fields"]).to have_key("status")
        end

        it "returns unprocessable_entity status" do
          patch url, headers: auth_header(employee)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end

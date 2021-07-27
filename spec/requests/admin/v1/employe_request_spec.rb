require "rails_helper"

RSpec.describe "Admin::V1::Employes", type: :request do
  let(:admin) { Employe.first }

  context "GET /employes" do
    let(:url) { "/admin/v1/employes" }
    let!(:employes) { create_list(:employe, 5) + [admin] }

    it "returns all Employes" do
      get url, headers: auth_header(admin)
      expect(body_json["employes"]).to contain_exactly *employes.as_json(only: %i(id name occupation))
    end

    it "returns success status" do
      get url, headers: auth_header(admin)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /employes" do
    let(:url) { "/admin/v1/employes" }

    context "with valid params" do
      let!(:employe_params) { { employe: attributes_for(:employe) }.to_json }

      it "adds a new Employe" do
        expect do
          post url, headers: auth_header(admin), params: employe_params
        end.to change(Employe, :count).by(1)
      end

      it "returns last added Employe" do
        post url, headers: auth_header(admin), params: employe_params
        expected_employe = Employe.last.as_json(only: %i(id name occupation))
        expect(body_json["employe"]).to eq expected_employe
      end

      it "returns success status" do
        post url, headers: auth_header(admin), params: employe_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:employe_invalid_params) do
        { employe: attributes_for(:employe, name: nil) }.to_json
      end

      it "does not add a new Employe" do
        expect do
          post url, headers: auth_header(admin), params: employe_invalid_params
        end.to_not change(Employe, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(admin), params: employe_invalid_params
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(admin), params: employe_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "PATCH /employes/:id" do
      let(:employe) { create(:employe) }
      let(:url) { "/admin/v1/employes/#{employe.id}" }

      context "with valid params" do
        let(:new_name) { "My new Employe" }
        let(:employe_params) { { employe: { name: new_name } }.to_json }

        it "updates Employe" do
          patch url, headers: auth_header(admin), params: employe_params
          employe.reload
          expect(employe.name).to eq new_name
        end

        it "returns updated Employe" do
          patch url, headers: auth_header(admin), params: employe_params
          employe.reload
          expected_employe = employe.as_json(only: %i(id name occupation))
          expect(body_json["employe"]).to eq expected_employe
        end

        it "returns success status" do
          patch url, headers: auth_header(admin), params: employe_params
          expect(response).to have_http_status(:ok)
        end
      end

      context "with invalid params" do
        let(:employe_invalid_params) do
          { employe: attributes_for(:employe, name: nil) }.to_json
        end

        it "does not update Employe" do
          old_name = employe.name
          patch url, headers: auth_header(admin), params: employe_invalid_params
          employe.reload
          expect(employe.name).to eq old_name
        end

        it "returns error message" do
          patch url, headers: auth_header(admin), params: employe_invalid_params
          expect(body_json["errors"]["fields"]).to have_key("name")
        end

        it "returns unprocessable_entity status" do
          patch url, headers: auth_header(admin), params: employe_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "DELETE /employes/:id" do
      let!(:employe) { create(:employe) }
      let(:url) { "/admin/v1/employes/#{employe.id}" }

      it "removes Employe" do
        expect do
          delete url, headers: auth_header(admin)
        end.to change(Employe, :count).by(-1)
      end

      it "returns success status" do
        delete url, headers: auth_header(admin)
        expect(response).to have_http_status(:no_content)
      end

      it "does not return any body content" do
        delete url, headers: auth_header(admin)
        expect(body_json).to_not be_present
      end

      it "does not remove unassociated product employes" do
        product_employes = create_list(:employe, 3)
        delete url, headers: auth_header(admin)
        present_product_employes_ids = product_employes.map(&:id)
        expected_product_employes = Employe.where(id: present_product_employes_ids)
        expect(expected_product_employes.ids).to contain_exactly(*present_product_employes_ids)
      end
    end
  end
end

require "rails_helper"

RSpec.describe "Admin::V1::Employees", type: :request do
  let(:admin) { Employee.first }

  context "GET /employees" do
    let(:url) { "/admin/v1/employees" }
    let!(:employees) { create_list(:employee, 5) + [admin] }

    it "returns all Employees" do
      get url, headers: auth_header(admin)
      expect(body_json["employees"]).to contain_exactly *employees.as_json(only: %i(id name occupation email))
    end

    it "returns success status" do
      get url, headers: auth_header(admin)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /employees" do
    let(:url) { "/admin/v1/employees" }

    context "with valid params" do
      let!(:employee_params) { { employee: attributes_for(:employee) }.to_json }

      it "adds a new Employee" do
        expect do
          post url, headers: auth_header(admin), params: employee_params
        end.to change(Employee, :count).by(1)
      end

      it "returns last added Employee" do
        post url, headers: auth_header(admin), params: employee_params
        expected_employee = Employee.last.as_json(only: %i(id name occupation email))
        expect(body_json["employee"]).to eq expected_employee
      end

      it "returns success status" do
        post url, headers: auth_header(admin), params: employee_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:employee_invalid_params) do
        { employee: attributes_for(:employee, name: nil) }.to_json
      end

      it "does not add a new Employee" do
        expect do
          post url, headers: auth_header(admin), params: employee_invalid_params
        end.to_not change(Employee, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(admin), params: employee_invalid_params
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(admin), params: employee_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PATCH /employees/:id" do
    let(:employee) { create(:employee) }
    let(:url) { "/admin/v1/employees/#{employee.id}" }

    context "with valid params" do
      let(:new_name) { "My new Employee" }
      let(:employee_params) { { employee: { name: new_name } }.to_json }

    context "PATCH /employees/:id" do
      let(:employee) { create(:employee) }
      let(:url) { "/admin/v1/employees/#{employee.id}" }

      context "with valid params" do
        let(:new_name) { "My new Employee" }
        let(:employee_params) { { employee: { name: new_name } }.to_json }

        it "updates Employee" do
          patch url, headers: auth_header(admin), params: employee_params
          employee.reload
          expect(employee.name).to eq new_name
        end

        it "returns updated Employee" do
          patch url, headers: auth_header(admin), params: employee_params
          employee.reload
          expected_employee = employee.as_json(only: %i(id name occupation email))
          expect(body_json["employee"]).to eq expected_employee
        end

        it "returns success status" do
          patch url, headers: auth_header(admin), params: employee_params
          expect(response).to have_http_status(:ok)
        end
      end

      it "returns updated Employee" do
        patch url, headers: auth_header(admin), params: employee_params
        employee.reload
        expected_employee = employee.as_json(only: %i(id name occupation nickname email))
        expect(body_json["employee"]).to eq expected_employee
      end

      it "returns success status" do
        patch url, headers: auth_header(admin), params: employee_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:employee_invalid_params) do
        { employee: attributes_for(:employee, name: nil) }.to_json
      end

      it "does not update Employee" do
        old_name = employee.name
        patch url, headers: auth_header(admin), params: employee_invalid_params
        employee.reload
        expect(employee.name).to eq old_name
      end

      it "returns error message" do
        patch url, headers: auth_header(admin), params: employee_invalid_params
        expect(body_json["errors"]["fields"]).to have_key("name")
      end

      it "returns unprocessable_entity status" do
        patch url, headers: auth_header(admin), params: employee_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "DELETE /employees/:id" do
    let!(:employee) { create(:employee) }
    let(:url) { "/admin/v1/employees/#{employee.id}" }

    it "removes Employee" do
      expect do
        delete url, headers: auth_header(admin)
      end.to change(Employee, :count).by(-1)
    end

    it "returns success status" do
      delete url, headers: auth_header(admin)
      expect(response).to have_http_status(:no_content)
    end

    it "does not return any body content" do
      delete url, headers: auth_header(admin)
      expect(body_json).to_not be_present
    end

    it "does not remove unassociated product employees" do
      product_employees = create_list(:employee, 3)
      delete url, headers: auth_header(admin)
      present_product_employees_ids = product_employees.map(&:id)
      expected_product_employees = Employee.where(id: present_product_employees_ids)
      expect(expected_product_employees.ids).to contain_exactly(*present_product_employees_ids)
    end
  end
end

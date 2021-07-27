module Admin::V1
  class EmployeesController < ApiController
    before_action :find_employee, only: [:update, :destroy, :show]

    def index
      # @employees = Employee.all
      @loading_service = Shared::ModelLoadingService.new(Employee.all, searchable_params)
      @loading_service.call
    end

    def create
      @employee = Employee.new
      @employee.attributes = employee_params
      save_employee!
    end

    def update
      @employee.attributes = employee_params
      save_employee!
    end

    def destroy
      @employee.destroy!
    rescue
      render_error(fields: @employee.errors.messages)
    end

    private

    def employee_params
      return {} unless params.has_key?(:employee)
      params.require(:employee).permit(:name, :nickname, :email, :password, :password_confirmation, :occupation)
    end

    def save_employee!
      @employee.save!
      render :show
    rescue
      render_error(fields: @employee.errors.messages)
    end

    def find_employee
      @employee = Employee.find(params[:id])
    end

    def searchable_params
      params.permit({ search: :name }, { order: {} }, :page, :length)
    end
  end
end

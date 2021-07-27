module Admin::V1
  class EmployesController < ApiController
    before_action :find_employe, only: [:update, :destroy, :show]

    def index
      @employes = Employe.all
    end

    def create
      @employe = Employe.new
      @employe.attributes = employe_params
      save_employe!
    end

    def update
      @employe.attributes = employe_params
      save_employe!
    end

    def destroy
      @employe.destroy!
    rescue
      render_error(fields: @employe.errors.messages)
    end

    private

    def employe_params
      return {} unless params.has_key?(:employe)
      params.require(:employe).permit(:name, :nickname, :email, :password, :password_confirmation, :occupation)
    end

    def save_employe!
      @employe.save!
      render :show
    rescue
      render_error(fields: @employe.errors.messages)
    end

    def find_employe
      @employe = Employe.find(params[:id])
    end
  end
end

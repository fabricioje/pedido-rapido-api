module Admin::V1
	class HomeController < ApiController
			def index
					render json: {message: 'Você esta logado!'}
			end
	end
end
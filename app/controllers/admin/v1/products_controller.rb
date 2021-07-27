module Admin::V1
  class ProductsController < ApiController
		before_action :find_product, only: [:update, :destroy, :show]

    def index
      @products = Product.all
    end

    def create
      @product = Product.new
      @product.attributes = product_params
			save_product!
    end

		def update
			@product.attributes = product_params
			save_product!
		end

		def destroy
			@product.destroy!
		rescue
			render_error(fields: @product.errors.messages)
		end
		
		
    private

		def product_params
			return {} unless params.has_key?(:product)
			params.require(:product).permit(:name, :description, :category_id, :price)
		end

		def save_product!
			@product.save!
			render :show
		rescue
			render_error(fields: @product.errors.messages)
		end

		def find_product
			@product = Product.find(params[:id])
		end
	end 
end
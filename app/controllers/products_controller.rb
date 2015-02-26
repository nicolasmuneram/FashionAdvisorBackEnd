require 'shopsense'	
class ProductsController < ApplicationController
    before_filter :authorize

	def index
		@products = []

        if params[:id]
            client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})
            response = client.search(params[:id])
            raw_products = JSON.parse(response)["products"]
            puts raw_products.inspect

            @products = raw_products.map! do |product|
                image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
                puts image.inspect
                {
                  'name' => product["name"],
                  'image' => image
                }
            end
            @search = params[:id]
        end
        @products
	end
end

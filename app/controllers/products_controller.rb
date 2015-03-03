require 'shopsense'	

class ProductsController < ApplicationController
    before_action :authenticate_user!

	def search
		@products = []

        if params[:id]

            client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})
            response = client.search(params[:id], 0, params[:num_results]||=10)
            raw_products = JSON.parse(response)["products"]
            @products = raw_products.map! do |product|
                image = product["images"].select { |i| i["sizeName"] == 'Large' }.pop
                {
                  'name' => product["name"],
                  'image' => image,
                  'description' => product["description"],
                  'price' => product["price"],
                  'url' => product["url"]
                }
            end
            @search = params[:id]
        end 
        render :json => {:products => @products, :auth_token => current_user.authentication_token }.to_json, :status => :ok
	end
end

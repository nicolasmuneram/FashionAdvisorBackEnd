require 'shopsense'	

class ProductsController < ApplicationController
    before_action :authenticate_user!

	def search
		@products = []
        if params[:search_param]
            client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})
            response = client.search(params[:search_param], 0, params[:num_results]||=10)
            raw_products = JSON.parse(response)["products"]
            @products = raw_products.map! do |p|
                image = p["images"].select { |i| i["sizeName"] == 'Large' }.pop
                product = {
                            'id' => p["id"].to_i,
                            'name' => p["name"],
                            'image_url' => image["url"],
                            'description' => p["description"],
                            'price' => p["priceLabel"],
                            'retailer_url' => p["url"],
                            'brand_name' => p["brandName"],
                            'retailer' => p["retailer"],
                            'in_wardrobe' => false
                          }
                if (!Product.exists?(p["id"].to_i))
                  Product.create(id:p["id"].to_i)
                end

                if(current_user.products.any?{|element| element.id == p["id"].to_i})
                  product["in_wardrobe"] = true
                end

                product
            end
            @search = params[:search_param]
        end

    #@products = searchById(471845271)

    respond_to do |format|
          format.html { render "index" }
          format.json { render :json => {:products => @products, :auth_token => current_user.authentication_token }.to_json, :status => :ok }
        end

  end


  def searchById(id)
    p = JSON.parse(Net::HTTP.get(URI.parse("http://api.shopstyle.com/api/v2/products/#{id}?pid=uid9921-26902161-26")))
    product = {
        'id' => p["id"].to_i,
        'name' => p["name"],
        'image_url' => p["image"]["sizes"]["Large"]["url"],
        'description' => p["description"],
        'price' => p["priceLabel"],
        'retailer_url' => p["url"],
        'brand_name' => p["brandName"],
        'retailer' => p["retailer"]["name"]
    }
  end

  def addProductToWardrobe()
    if(current_user.products.find_by_id(params[:product_id]) == nil)
      current_user.products << Product.find(params[:product_id])
      product = searchById(params[:product_id])
      render json: {response: "Product added to wardrobe", product: product}
    else
      render json: {response: "Sorry, this item is already in your wardrobe!", product: product}
    end
  end

end


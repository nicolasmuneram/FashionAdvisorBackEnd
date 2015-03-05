require 'shopsense'

class ProductsController < ApplicationController
  before_action :authenticate_user!

  # GET '/search/:search_param'
  def search
    @products = []
    if params[:search_param]

      client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})

      response = client.search(params[:search_param], 0, params[:num_results] ||= 10)

      raw_products = JSON.parse(response)["products"]

      format_products_hash(raw_products)

      @search = params[:search_param]

    end

    render json: { products: @products, auth_token: current_user.authentication_token }
  end

  # @param [Hash] products_hash Raw Hash returned by the API
  # @return [Object] Returns the formatted hash with the proper keys and values.
  def format_products_hash(products_hash)
    @products = products_hash.map! do |p|

      image = p["images"].select { |i| i["sizeName"] == 'Large' }.pop
      product = {
          :id => p["id"].to_i,
          :name => p["name"],
          :image_url => image["url"],
          :description => p["description"],
          :price => p["priceLabel"],
          :retailer_url => p["url"],
          :brand_name => p["brandName"],
          :retailer => p["retailer"]["name"],
          :in_wardrobe => false
      }
      Product.create(p["id"].to_i)

      if current_user.has_product_in_wardrobe?(p["id"].to_i)
        product['in_wardrobe'] = true
      end

      product
    end
  end

  # Search a product by a given ID in the ShopStyle API.
  def search_by_id(id)
    p = JSON.parse(Net::HTTP.get(URI.parse("http://api.shopstyle.com/api/v2/products/#{id}?pid=uid9921-26902161-26")))
    {
        :id => p["id"].to_i,
        :name => p["name"],
        :image_url => p["image"]["sizes"]["Large"]["url"],
        :description => p["description"],
        :price => p["priceLabel"],
        :retailer_url => p["url"],
        :brand_name => p["brandName"],
        :retailer => p["retailer"]["name"]
    }
  end

  # POST 'user/products'
  def add_product_to_wardrobe()
    if current_user.products.find_by_id(params[:product_id]) == nil

      current_user.products << Product.find(params[:product_id])
      product = search_by_id(params[:product_id])

      render json: {response: "Product added to wardrobe", product: product}
    else

      render json: {response: "Sorry, this item is already in your wardrobe!", product: product}
    end

  end



end


require 'shopsense'

class ProductsController < ApplicationController
  include ShopStyleApiHelper
  before_action :authenticate_user!

  
  # GET '/search/:search_param'
  def search
    @products = []
    if params[:search_param]

      client = Shopsense::API.new({'partner_id' => 'uid9921-26902161-26'})

      response = client.search(params[:search_param], 0, params[:num_results] ||= 10)

      raw_products = JSON.parse(response)["products"]

      format_products_hash(raw_products, current_user)

      @search = params[:search_param]

    end

    render json: { products: @products, auth_token: current_user.authentication_token }
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

  # GET 'user/products'
  def bring_products_from_wardrobe()
    wardrobe_products = []
    current_user.products.each do |product|
        wardrobe_products << search_by_id(product.id)
    end

    render json: {response: "Wardrobe items", wardrobe_products: wardrobe_products}
  end


end


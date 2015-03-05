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


    end
    render json: { status: 0, data: {products: raw_products} }
  end





  # POST 'user/products'
  def add_product_to_wardrobe()
    if current_user.products.find_by_id(params[:product_id]) == nil

      current_user.products << Product.find(params[:product_id])
      product = search_by_id(params[:product_id])

      render json: {status: 0, data: {product: product}}
    else

      render json: {status: 1, data: nil}
    end

  end

  # GET 'user/products'
  def bring_products_from_wardrobe()
    wardrobe_products = []
    current_user.products.each do |product|
        wardrobe_products << search_by_id(product.id)
    end

    render json: {status: 0, data:{wardrobe_products: wardrobe_products}}
  end


end


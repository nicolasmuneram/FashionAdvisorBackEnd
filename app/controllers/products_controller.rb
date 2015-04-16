require 'shopsense'
require 'FashionAdvisorCore'
class ProductsController < ApplicationController
  before_action :authenticate_user!

  # GET '/search/:search_param'
  # This method uses the Shopsense API to search products in their DB by their name, and renders the products in JSON format
  def search
    raw_products = FashionAdvisorCore::search_product(search_param,current_user.id)
    if raw_products != nil
      render json: { status: 0, data: {products: raw_products} }
    else
      render json: { status: 1, data: nil}
    end
  end

  # POST 'user/products'
  # Adds a specific product to the current users wardrobe
  def add_product_to_wardrobe
    if product_id_param && FashionAdvisorCore::add_product_to_wardrobe(current_user.id, product_id_param)
      render json: {status: 0, data: nil}
    else
      render json: {status: 1, data: nil}
    end
  end

  # GET 'user/products'
  # Brings the current users wardrobe products and returns the array of products in a JSON format
  def bring_products_from_wardrobe
    wardrobe_products = FashionAdvisorCore::view_products_in_wardrobe(current_user.id)
    if wardrobe_products != nil
      render json: {status: 0, data:{wardrobe_products: wardrobe_products}}
    else
      render json: {status: 1, data:{wardrobe_products: nil}}
    end
  end

private
  def product_id_param
    params[:product_id]
  end

  def search_param
    params[:search_param]
  end

  def num_results_param
    params[:num_results]
  end

end


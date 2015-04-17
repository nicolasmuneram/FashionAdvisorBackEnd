require "FashionAdvisorCore/version"
require 'FashionAdvisorCore/Entities/product'
require 'FashionAdvisorCore/Entities/user'
require 'FashionAdvisorCore/Repositories/repository'
require 'FashionAdvisorCore/UseCases/add_product_to_wardrobe_use_case'
require 'FashionAdvisorCore/UseCases/get_products_in_wardrobe_use_case'
require 'FashionAdvisorCore/UseCases/search_products_use_case'

module FashionAdvisorCore
  class << self

    def configure
      yield self
    end

    def search_product(search_param,user_id)
      data = {'search_term' => search_param,'user_id' => user_id}
      use_case = UseCases::SearchProductsUseCase.new(data,Repositories::Repository.for(:product),Repositories::Repository.for(:user))
      use_case.execute
    end

    def add_product_to_wardrobe(user_id, product_id )
      data = {'user_id' => user_id, 'product_id' => product_id}
      use_case = UseCases::AddProductToWardrobeUseCase.new(data,Repositories::Repository.for(:product),Repositories::Repository.for(:user))
      use_case.execute
    end

    def get_products_in_wardrobe(user_id)
      data = {'user_id' => user_id}
      use_case = UseCases::GetProductsInWardrobeUseCase.new(data,Repositories::Repository.for(:product),Repositories::Repository.for(:user))
      use_case.execute
    end
  end
end




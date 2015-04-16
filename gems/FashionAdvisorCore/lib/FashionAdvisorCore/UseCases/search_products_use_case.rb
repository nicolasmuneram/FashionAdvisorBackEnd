require 'FashionAdvisorCore/UseCases/base/use_case'
module FashionAdvisorCore
  module UseCases
    class SearchProductsUseCase < UseCase

      attr_accessor :data,:product_repo,:user_repo

      def initialize(data,product_repo,user_repo)
        @data = data
        @product_repo = product_repo
        @user_repo = user_repo
      end

      def execute
        user = user_repo.get_user(data['user_id'])
        products = product_repo.get_products(data['search_term'])
        products.each { |product|
          product['in_wardrobe'] = user.contains_product(FashionAdvisorCore::Entities::Product.new(product['id']))
        }
        products
      end
    end
  end
end
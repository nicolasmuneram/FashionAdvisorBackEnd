require 'FashionAdvisorCore/UseCases/base/use_case'
module FashionAdvisorCore
  module UseCases
    class GetProductsInWardrobeUseCase < UseCase

      attr_accessor :data,:user_repo,:product_repo

      def initialize(data,product_repo, user_repo)
        @data = data
        @user_repo = user_repo
        @product_repo = product_repo
      end

      def execute
        user = user_repo.get_user(data['user_id'])
        product_collection = []
        if user.exists?
          products = user.products
          products.each do |product|
            product_collection << product_repo.search_product_details(product.id)
          end
        end
        product_collection
      end
    end
  end
end
require 'FashionAdvisorCore/UseCases/base/use_case'
module FashionAdvisorCore
  module UseCases
    class AddProductToWardrobeUseCase < UseCase

      attr_accessor :data,:product_repo,:user_repo

      def initialize(data,product_repo,user_repo)
        @data = data
        @product_repo = product_repo
        @user_repo = user_repo
      end

      def execute
        product = product_repo.get_product(data['product_id'])
        user = user_repo.get_user(data['user_id'])
        result = false
        if user.exists? && product.exists? && !user.contains_product(product)
          user_repo.add_product_to_user(user,product)
          result = true
        end
        result
      end

    end
  end
end

module FashionAdvisorCore
  module Entities
    class User
      attr_accessor :id
      attr_accessor :email
      attr_accessor :password
      attr_accessor :token
      attr_accessor :products

      def initialize(email, password)
        @password = password
        @email = email
        @products = {}
      end

      def exists?
        (id!=nil && id!='')
      end

      def valid?
        (email!=nil && email!='') && (password!=nil && password!='')
      end

      def contains_product(product)
        i = 0
        while i < products.size
          if products[i].id == product.id
              return true
          end
          i = i + 1
        end
        false
      end
    end
  end
end
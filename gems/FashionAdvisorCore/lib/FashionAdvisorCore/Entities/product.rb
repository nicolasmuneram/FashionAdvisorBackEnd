module FashionAdvisorCore
  module Entities
    class Product
      attr_accessor :id

      def initialize(id)
        @id = id
      end

      def exists?
        (id != nil) && (id != '')
      end

    end
  end
end
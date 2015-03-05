class Product < ActiveRecord::Base

  has_and_belongs_to_many :users

  # Method override this is to only create a product if it doesn't exist already in the database
  # this handles authentication errors.
  def self.create(product_id)
    # Only create the product if the product doesn't exist.
    unless Product.exists?(product_id)
      super('id' => product_id)
    end
  end



end

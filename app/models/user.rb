class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #This makes the User model the one that acts as th
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :products

  # @param [Integer] product_id, this is the ID of the product we are looking for in the wardrobe
  # @return [Boolean] True if the product is in the users wardrobe.
  def has_product_in_wardrobe? (product_id)
      products.any? { |element| element.id == product_id}
  end

end

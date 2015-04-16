class UserRepositoryAdapter

  def get_user(user_id)
    serialize User.find_by_id(user_id)
  end

  def exists?(email)
     User.find_by_email(email) != nil
  end


  def add_product_to_user(user, product)
    db_user = User.find_by_id(user.id)
    db_user.products << Product.find_by_id(product.id)
  end

  private

  def serialize(user)
    entity = FashionAdvisorCore::Entities::User.new(nil,nil)
    entity.id = nil
    if user!=nil
      entity = FashionAdvisorCore::Entities::User.new(user.email,user.password)
      entity.products = user.products
      entity.id = user.id
    end
    entity
  end

end
#FashionAdvisorCore::register_repo(:product,ProductRepositoryAdapter.new)

#FashionAdvisorCore::register_repo(:user,UserRepositoryAdapter.new)

FashionAdvisorCore::Repositories::Repository.register :product, ProductRepositoryAdapter.new

FashionAdvisorCore::Repositories::Repository.register :user, UserRepositoryAdapter.new

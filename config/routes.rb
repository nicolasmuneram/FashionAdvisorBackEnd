Rails.application.routes.draw do

  # Tells the router to use the controllers located in /controllers/users
  # This routes are specifically for the users registration, authentication and authorization
  # done by the devise gem and the simple toke authentication gems.
  devise_for :users, controllers: {
                                    sessions: 'users/sessions',
                                    registrations: 'users/registrations'
                                  }


  root 'products#search'

  get 'search/:search_param' => 'products#search'

  get 'user/wardrobe' => 'products#bring_products_from_wardrobe'

  post 'user/products' => 'products#add_product_to_wardrobe'


end

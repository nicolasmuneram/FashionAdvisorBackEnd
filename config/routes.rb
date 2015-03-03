Rails.application.routes.draw do

  # Tells the router to use the controllers located in /controllers/users
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # You can have the root of your site routed with "root"
  root 'products#search'
  get 'search/:id' => 'products#search'
 

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :null_session

  #From simple token authentication gem.
  acts_as_token_authentication_handler_for User
end

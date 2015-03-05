class Users::RegistrationsController < Devise::RegistrationsController


  # This will be deleted in the final project, helps us to render an HTML layout to easily register in
  # the application.
  # GET /resource/sign_up
   def new

     build_resource({})

     @validatable = devise_mapping.validatable?
     if @validatable
       @minimum_password_length = resource_class.password_length.min
     end
     respond_with self.resource
   end

   # Overridden of the super method, done this to change the way it renders, just in a JSON format.
   # POST /resource
   def create
     build_resource(sign_up_params)
     resource_saved = resource.save
     yield resource if block_given?
     if resource_saved
       sign_up(resource_name, resource)
       render json: {
                  status: 0,
                  data:{ auth_token: current_user.authentication_token,
                         email: resource.email}
              }
     else
       # Couldn't register the user, something happened.
       clean_up_passwords resource
       @validatable = devise_mapping.validatable?
       if @validatable
         @minimum_password_length = resource_class.password_length.min
       end
       render json: {
                  status: 1,
                  data: nil
              }
     end
   end


end

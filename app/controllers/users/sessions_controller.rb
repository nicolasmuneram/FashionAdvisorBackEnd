class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  # This request creates the session when a user tries to login, if it fails it redirects to the failure method.
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    render json: {response: 'Login successful.', auth_token: current_user.authentication_token, email: resource.email}
  end

  # When called, it means that the login has failed.
  def failure
     render json: {response: false, auth_token: nil}
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    render json: {response: 'Logout successful.'}
  end

  


end

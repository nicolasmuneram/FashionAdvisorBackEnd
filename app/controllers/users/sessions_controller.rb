class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  # This request creates the session when a user tries to login, if it fails it redirects to the failure method.
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    render :json => {:response => 'ok', :auth_token => current_user.authentication_token }.to_json, :status => :ok
  end

  # When called, it means that the login has failed.
  def failure
     render json: {success: false, errors: "Login failed!"}
  end

end

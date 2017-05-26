class AuthenticationController < Devise::OmniauthCallbacksController

  def vkontakte
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "VKontakte") if is_navigational_format?
    else
      session["devise.vk_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
end

  protected

  # Overrided
  def after_omniauth_failure_path_for(_)
    return_path
  end

  def return_path
    session.delete(:guest_return_url) || root_path
  end
end
class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permmited_parameter, if: :devise_controller?

  private
  def configure_permmited_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

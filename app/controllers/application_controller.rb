# Top level controller for basic behavior
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :config_params, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:error] = "sorry, you can't go to that page."
    redirect_to root_path
  end

  protected

  def config_params
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:name, :email, :password)
    }
  end
end

class ApplicationController < ActionController::Base
  layout :layout_by_resource

  def after_sign_in_path_for(resource_or_scope)
    "/admin/projects"
  end

  def after_sign_out_path_for(resource_or_scope)
    "/admin/projects"
  end

  def redirect_to_https
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  before_filter :cors_preflight_check, :redirect_to_https
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  private

  def layout_by_resource
    if devise_controller?
      "admin"
    else
      "application"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

end

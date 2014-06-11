class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protected

  def require_login
    unless current_user
      flash[:alert] = 'You must be connected to view this page.'
      redirect_to connect_path(origin: request.path)
    end
  end

  private

  def current_user
    user_id = session[:user_id]['$oid']
    @current_user ||= User.where(id: user_id).first if user_id
  end

  helper_method :current_user
end

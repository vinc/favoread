class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(auth)
    session[:user_id] = user.id
    if user.name? && user.email?
      redirect_to request.env['omniauth.origin'] || root_path
    else
      redirect_to profile_path
    end
  end

  def destroy
    respond_with reset_session, location: root_path
  end

  protected

  def auth
    request.env['omniauth.auth']
  end
end

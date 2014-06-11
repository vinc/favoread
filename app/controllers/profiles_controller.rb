class ProfilesController < ApplicationController
  before_filter :require_login

  expose(:user, attributes: :user_params) { current_user }

  def update
    user.attributes = user_params # FIXME: decent_exposure should do this
    if user.save
      flash[:notice] = 'Profile was successfully updated.'
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

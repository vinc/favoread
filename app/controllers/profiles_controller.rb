class ProfilesController < LoggedController
  expose(:user) { current_user }

  def update
    user.attributes = user_params

    if user.save
      respond_with user, location: profile_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

class UsersController < ApplicationController

  load_and_authorize_resource :user

  def index
    @users = @users.paginate(page: params[:page])
    respond_with(@users)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private


  def secure_params
    params.require(:user).permit(role_ids: [])
  end

end

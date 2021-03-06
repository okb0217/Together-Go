class UsersController < ApplicationController
	before_action :authenticate_user!, except:[:top, :about]

  def top
  end

  def about
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    	@user = User.find(params[:id])
    	unless current_user.id == @user.id
        redirect_to user_path(current_user.id)
      end
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "会員情報を更新しました！"
        redirect_to user_path(@user)
      else
        render action: :edit
      end
  end

  private
	def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :age, :is_gender)
  end

end

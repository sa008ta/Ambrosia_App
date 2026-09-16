class UsersController < ApplicationController
  def new
    @role = normalized_role(params[:role])
    @user = User.new(role: @role)
  end

  def create
    @role = normalized_role(params[:role])
    @user = User.new(user_params.merge(role: @role))

    if @role == "staff" && params[:staff_password].to_s != User::STAFF_REGISTRATION_PASSWORD
      @user.errors.add(:base, "店員パスワードが正しくありません。")
      render :new, status: :unprocessable_entity and return
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "#{@user.role == "staff" ? "店員" : "お客様"}として登録が完了しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end

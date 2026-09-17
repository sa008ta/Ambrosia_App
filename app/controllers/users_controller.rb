class UsersController < ApplicationController
  before_action :require_login, only: [:update_account, :update_language]

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

  def update_account
    @user = current_user
    return redirect_to root_path, alert: "ログインしてください。" unless @user

    if @user.update(account_params)
      redirect_to settings_path, notice: "アカウント情報を更新しました。"
    else
      render "pages/account_top", status: :unprocessable_entity
    end
  end

  def update_language
    @user = current_user
    return redirect_to root_path, alert: "ログインしてください。" unless @user

    if @user.update(language_params)
      redirect_to home_path, notice: "言語設定を更新しました。"
    else
      render "pages/language_settings", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def account_params
    params.require(:user).permit(:name, :username, :email)
  end

  def language_params
    params.require(:user).permit(:language)
  end
end


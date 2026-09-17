class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
    @role = normalized_role(params[:role])
  end

  def create
    @role = normalized_role(params[:role])
    user = User.find_by(username: params[:username], role: @role)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "#{user.name}さん、ようこそAmbrosiaへ。"
    else
      flash.now[:alert] = "ユーザーネーム、パスワード、またはアカウント種別が正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました。"
  end
end

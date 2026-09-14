class SessionsController < ApplicationController
  def new
    @role = normalized_role(params[:role])
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "#{user.name}さん、ようこそAmbrosiaへ。"
    else
      flash.now[:alert] = "ユーザーネームまたはパスワードが正しくありません。"
      @role = normalized_role(params[:role])
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました。"
  end
end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTTP headers
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    return if logged_in?

    redirect_to root_path, alert: "ログインしてください。"
  end

  def require_logout
    return unless logged_in?

    redirect_to home_path, notice: "すでにログイン済みです。"
  end

  def require_staff
    return if logged_in? && current_user&.staff?

    redirect_to home_path, alert: "店員アカウントでログインしてください。"
  end

  def require_customer
    return if logged_in? && current_user&.customer?

    redirect_to home_path, alert: "この機能はお客様アカウント専用です。"
  end

  def normalized_role(role)
    return "customer" unless role.present?

    role.to_s.in?(%w[customer staff]) ? role.to_s : "customer"
  end
end

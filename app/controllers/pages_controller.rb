class PagesController < ApplicationController
  before_action :require_login, only: [:home]

  def landing
  end

  def loading
    @next_path = root_path
  end

  def home
    @user = current_user
  end
end

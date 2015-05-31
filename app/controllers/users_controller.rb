class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  private
  def find_user
    @user = User.includes(:support_duties).find params[:id]
  end
end
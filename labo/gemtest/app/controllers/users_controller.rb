class UsersController < ApplicationController
  #ページネーション
  PER = 10

  def index
    #@users = User.all
    @users = User.page(params[:page]).per(PER)
  end

  def show
    @user = User.find(params[:id])
  end
end

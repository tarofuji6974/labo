class UsersController < ApplicationController
  #ページネーション
  PER = 10

  def index
    #@users = User.all
    @users = User.page(params[:page]).per(PER)

    #ransack
    @q = User.ransack(params[:q])
    @ask = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end
end

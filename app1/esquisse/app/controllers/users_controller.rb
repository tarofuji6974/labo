class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @ask = @q.result(distinct: true)
    #@users = User.all
    @qq = User.ransack(params[:qq])
    @ar = @qq.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end
end
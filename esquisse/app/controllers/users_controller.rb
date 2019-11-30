class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #新規ユーザー登録アクション
    @user = User.new(
      name: params[:name],
      password_digest: params[:password_digest],
      image_name: "default_user_image.png"
    )

    @repassword = params[:repassword]

    #パスワードチェック
    unless @user.password_digest == @repassword
      #パスワードが一致しなかった場合、リターンする
      flash[:notice] = "パスワードが一致しませんでした"
      render("/users/new")
      return
    end

    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"

      #ユーザー詳細画面への遷移(仮置き)
      redirect_to("/")
    else
      #登録失敗の場合、ページ遷移させない
      render("/users/new")
    end
  end

  def index
    @user = User.find_by(id:params[:id])

    @photos = Photo.find_by(user_id:params[:id])

  end

  def edit
  end
end

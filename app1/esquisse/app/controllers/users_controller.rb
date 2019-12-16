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

  #プロフィール編集画面の表示
  def profile
    @user = User.find(params[:id])
  end

  #プロフィール更新アクション
  def update
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.password = params[:password]
    @user.profile = params[:profile]

    #パスワードが不一致だったときの処理
    if @user.password != params[:repassword]
      flash[:notice] = "パスワードが一致しません"
      render("/users/profile")
      return
    end

    #画像の保存処理
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"

      image = params[:image]

      File.binwrite("public/user_image/#{@user.image_name}",image.read)
    end

    #ユーザー情報の更新処理
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to(root_path)
    else
      #更新に失敗した場合は画面遷移しない
      render("/users/profile")
    end
  end
end
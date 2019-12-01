class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #新規ユーザー登録アクション
    @user = User.new(
      name: params[:name],
      password: params[:password],
      image_name: "default_user_image.png"
    )

    @repassword = params[:repassword]

    #パスワードチェック
    unless @user.password == @repassword
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

    @photos = Photo.where(user_id:params[:id])

  end

  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.profile = params[:profile]
    @user.password_digest = params[:password_digest]
    @repassword = params[:repassword]

    #画像の保存処理
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"

      image = params[:image]

      File.binwrite("public/user_image/#{@user.image_name}",image.read)
    end

    #パスワードの確認処理
    unless @user.password_digest == @repassword
      render("/users/edit")
      return
    end

    #ユーザー情報の更新処理
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      #更新に失敗した場合は画面遷移しない
      render("/users/edit")
    end
  end
end

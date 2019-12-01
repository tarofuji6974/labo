class HomeController < ApplicationController
  def login

  end

  def index
    #ユーザー名とパスワードが一致する情報を取得
    @user = User.find_by(
      name: params[:name],
      password_digest: params[:password_digest]
      )

    if @user
      #入力結果が一致した場合の処理
      #セッション情報を保持する
      #session[:user_id] = @user.id
      flash[:notice] = "ログインしました"

      #セッションの保存
      session[:user_id] = @user.id
      #ユーザー個別のページへリダイレクト
      redirect_to("/users/#{@user.id}")
    else
      #ログインできなかった場合の処理
      #renderで返す設定を行う
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @name = params[:name]
      @password = params[:password]

      render("/home/login")
    end
  end

  def logout
    #ログアウト実行時、セッションを切りログイン画面にリダイレクトする
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
end

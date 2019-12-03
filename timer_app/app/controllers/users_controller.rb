class UsersController < ApplicationController

  def index
    #全ユーザー情報を取得
    @users = User.all.order(created_at: :desc)
  end

  def new
    #新規ユーザー登録
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

      #ユーザー詳細画面への遷移
      redirect_to("/users/:id")
    else
      #登録失敗の場合、ページ遷移させない
      render("/users/new")
    end
  end

  def show
    #ユーザーの個別情報を取得
    @user = User.find_by(id: params[:id])

    #ユーザーの学習記録情報を取得
    @logs = Log.all.order(created_at: :desc)
  end

  def edit
    #ユーザーの個別情報を取得
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id:params[:id])
    @user.name = params[:name]
    @user.password_digest = params[:password_digest]

    #画像の保存処理
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"

      image = params[:image]

      File.binwrite("public/user_image/#{@user.image_name}",image.read)
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

  def record
    require 'date'
    #ユーザー情報を取得
    @user = User.find_by(id:params[:id])

    #現在日時を取得
    @nowTime = DateTime.now

    @logs = Log.new
  end

  def record_create
    require 'date'
    #ユーザーIDを取得
    @user = User.find_by(id:params[:id])

    #記録作成
    @logs = Log.new(
      user_id: @user.id,
      user_name: @user.name,
      #start_time: params[:start_time],
      start_time: DateTime.now,
      menu: params[:menu]
    )

    #記録保存処理
    if @logs.save
      flash[:notice] = "学習を記録しました(開始)"

      #ユーザーページに戻る
      redirect_to("/users/#{@user.id}")
    else
      #失敗時のアクション
      @nowTime = DateTime.now
      render("/users/record")
    end
  end

  def record_edit
    #学習記録情報を取得
    @logs = Log.find_by(id:params[:id])

    @end_time = @logs.end_time

    if @end_time != nil
      @df = time_diff(@logs.start_time,@logs.end_time)
    end
  end

  def record_update

    @logs = Log.find_by(id:params[:id])

    @logs.end_time = params[:end_time]
    @logs.menu = params[:menu]

    if !start_end_check?(params[:start_time],params[:end_time])
      render("/users/record_edit")
      return
    end

    #学習記録更新処理
    if @logs.save
      flash[:notice] = "学習を記録しました(終了)"

      #ユーザーページに戻る
      redirect_to("/users/#{@logs.user_id}")
    else
      #失敗時のアクション
      render("/users/record_edit")
    end
  end

    #開始日時 < 終了日時にならないようチェック
  def start_end_check?(start_time,end_time)
    require 'date'

    #終了時間のnilチェック
    if end_time == nil
      flash[:notice] = "終了時間が未入力です"
      return false
    end

    if !date_valid?(end_time)
      flash[:notice] = "終了日時を正しく入力してください(例:yyyy/mm/dd hh:mm:ss)"
      return false
    end

    @start_time = DateTime.parse(start_time)
    @end_time = DateTime.parse(end_time)

    #errors.add(:終了日時, "を正しく入力してください。") unless
    unless @start_time < @end_time
      flash[:notice] = "終了時間 > 開始時間は入力できません"
      return false
    end

    return true
  end

  def date_valid?(str)
    #日付が正しく変換できるか。できない場合はfalseを返す
    !! DateTime.parse(str) rescue false
  end

  def view
    #学習記録情報を取得
    @logs = Log.find_by(id:params[:id])
  end

  def record_destroy
    @logs = Log.find_by(id:params[:id])
    @id = @logs.user_id
    #学習記録を削除
    @logs.destroy

    flash[:notice] = "記録を削除しました"
    redirect_to("/users/#{@id}")
  end

  #学習時間の計算処理
  def time_diff(start_time,end_time)
    seconds_diff = (start_time - end_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def login_form

  end

  def login
        #ユーザー名とパスワードが一致する情報を取得
    @user = User.find_by(
      name: params[:name],
      password_digest: params[:password_digest]
      )

    if @user
      #入力結果が一致した場合の処理
      #セッション情報を保持する
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"

      #ユーザー個別のページへリダイレクト
      redirect_to("/users/#{@user.id}")
    else
      #ログインできなかった場合の処理
      #renderで返す設定を行う
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @name = params[:name]
      @password_digest = params[:password_digest]

      render("users/login_form")
    end
  end

  def logout
    #ログアウト実行時、セッションを切りログイン画面にリダイレクトする
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
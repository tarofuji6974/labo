class ThemeController < ApplicationController
  PER = 10  #投稿の表示数

  #お題の閲覧
  def view
     #ransack
    @q = Theme.ransack(params[:q])

    #作成日時の降順になるようソート
    @q.sorts   = 'created_at desc' if @q.sorts.empty?

    @ask = @q.result(distinct: true)

    #ページング(作成日時の降順に表示させるよう修正の必要あり)
    @themes = Theme.page(params[:page]).per(PER)

  end

  #お題の作成ページ表示
  def create
    @user = User.find(params[:id])

    if @user.name ==nil
      flash[:notice] = '名前の入力をお願いします。設定が完了するとお題の投稿が可能になります'
      redirect_to("/profile_edit/#{@user.id}")

      return
    end

    @theme = Theme.new
  end

  #お題の作成
  def create_theme
    require 'securerandom'

    @theme = Theme.new(
      theme: params[:theme],
      user_id: params[:user_id],
      user_name: params[:user_name],
      url: SecureRandom.urlsafe_base64
    )

    @id = params[:user_id]

    #保存処理
    if @theme.save
      flash[:notice] = 'お題を作成しました'
      redirect_to(root_path)
    else
      #javascriptで入力チェックが必要
      render("/create/#{@id}")
    end
  end

  #お題の編集(ステータス切り替えのみ)
  def theme_edit

  end

  def profile
    if current_user
      @user = User.find(current_user.id)

      @theme = Theme.where(user_id: @user.id).order(created_at: :asc)

    else
      redirect_to("/users/sign_in")
    end
  end

  #プロフィールの編集
  def profile_edit
    @user = User.find(params[:id])

    if @user.name == nil
      flash[:notice] = '名前の入力をお願いします。設定が完了するとお題の投稿が可能になります'
    end
  end

  def profile_update
    user =  User.find(params[:id])
    user.name = params[:name]
    user.profile = params[:profile]

    if user.save
      flash[:notice] = "編集が完了しました"
      redirect_to(root_path)

    else
      render("/profile_edit/#{user.id}")
    end
  end

  #コメントの追加
  def comment

  end

  #お題の削除
  def delete
    theme = Theme.find_by(id: params[:id])
    theme.destroy

    flash[:notice] = "お題を削除しました"
    redirect_to(root_path)
  end
end

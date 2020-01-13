class ThemeController < ApplicationController

  #トップ画面(ログイン)
  def top
    if current_user
      @user = User.find(current_user.id)

      @theme = Theme.where(user_id: @user.id).order(created_at: :asc)
    else
      redirect_to("/users/sign_in")
    end
  end

  #お題の閲覧
  def view
  end

  #お題の作成ページ表示
  def create
    @user = User.find(params[:id])
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
  end

  #プロフィールの編集
  def profile_edit

  end

  #コメントの追加
  def comment
  end

  #お題の削除
  def delete
  end
end

class ThemeController < ApplicationController

  #トップ画面(ログイン)
  def top
    if current_user
      @user = User.find(current_user.id)
    else
      redirect_to("/users/sign_in")
    end
  end

  #お題の閲覧
  def view
  end

  #お題の作成
  def create
  end

  #お題の編集(ステータス切り替えのみ)
  def edit
  end

  #コメントの追加
  def comment
  end

  #お題の削除
  def delete
  end
end

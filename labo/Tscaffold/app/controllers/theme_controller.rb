class ThemeController < ApplicationController
  PER = 10  #投稿の表示数

  def entry_point
    if current_user
      Redis.current.set(current_user.id, current_user.name)
      redirect_to("/profile/#{Redis.key[0]}")
    else
      redirect_to("/users/sign_in")
    end
  end

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
      url: SecureRandom.urlsafe_base64,
      status: "募集中"
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

  #お題の編集(ステータス切り替えが可能)
  def theme_edit
    @theme = Theme.find(params[:id])
    @comments = Comment.where(user_id: @theme.id).order(created_at: :asc)

    #お題の投稿者でない場合、ページ遷移させる
    if @theme.user_id != current_user.id
      flash[:notice] = "お題の投稿者ではありませんので、編集できません"
      redirect_to(root_path)
    end
  end

  #お題の募集終了
  def theme_update
    @theme = Theme.find(params[:id])
    @theme.status = "募集終了"

    if @theme.save
        flash[:notice] = "ステータス変更完了"
        redirect_to("/theme_edit/#{@theme.id}/#{@theme.url}")
    else
        flash[:notice] = "ステータスを変更できませんでした"
        redirect_to("/theme_edit/#{@theme.id}/#{@theme.url}")
    end
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

  #コメントの表示と投稿ページ
  def theme_answer
    @theme = Theme.find(params[:id])
    @comments = Comment.where(user_id: @theme.id).order(created_at: :asc)

    #URLが一致していない場合
    if @theme.url != params[:url]
      flash[:notice] = "URLが間違っています"
      redirect_to("/view")
      return
    end

    #投稿者の場合
    if @theme.user_id == current_user.id
      flash[:notice] = "投稿者は自分の投稿にコメントすることはできません"
      redirect_to("/theme_edit/#{@theme.id}/#{@theme.url}")
    end

    @comment = Comment.new
  end

  #コメントの投稿
  def comments
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.new(
      user_id: @theme.id,
      comment: params[:comment]
    )

    #コメント投稿完了の判断
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to("/theme_answer/#{@theme.id}/#{@theme.url}")
    else
      #flash[:notice] = "#{@comment.user_id}/#{@comment.comment}"
      #redirect_to(root_path)
      flash[:notice] = "コメントを投稿できませんでした"
      redirect_to("/theme_answer/#{@theme.id}/#{@theme.url}")
    end
  end

  #お題の削除
  def delete
    theme = Theme.find_by(id: params[:id])
    theme.delete


    #Theme.where(id: params[:id]).destroy_all

    flash[:notice] = "お題を削除しました"
    redirect_to(root_path)
  end
end
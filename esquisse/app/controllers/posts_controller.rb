class PostsController < ApplicationController
  def view
    #写真の作成日時順に表示
    @photos = Photo.all.order(created_at: :desc)
  end

  def post_form
    @user = User.find_by(id:params[:id])

    @photo = Photo.new
  end

  def post
    require 'date'

    @user = User.find_by(id:params[:id])

    @photo = Photo.new(
        user_id: @user.id,
        user_name: @user_name,
        comment: params[:comment],
        stars: 0
      )

    #画像の保存処理
    if params[:image_name]
      #ファイル名は「現在日時分秒 + 名前 + .jpg」とする
      nowTime = DateTime.now
      @photo.image_name = nowTime.strftime("%Y-%m-%d %H:%M:%S") +
                          @user.name + ".jpg"

      image = params[:image_name]

      File.binwrite("public/photo_image/#{@photo.image_name}",image.read)
    end

    if @photo.save
      flash[:notice] = "投稿を完了しました"

      #一覧ページにリダイレクトする
      redirect_to("/view")
    else
      #保存失敗の場合、ページ遷移させない
      render('/posts/post_form')
    end
  end

  def favorite
  end
end
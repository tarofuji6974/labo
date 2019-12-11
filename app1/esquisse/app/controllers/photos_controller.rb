class PhotosController < ApplicationController
  PER = 10  #投稿の表示数
  before_action :authenticate_user!, only: [:show, :create]
  def index
    @user = User.find(current_user.id)
  end

  def show
    @photo = Photo.find(params[:id])
    @fav = Favorite.new
  end

  def create
    require 'date'
    
    @photo = Photo.new(
      user_id: current_user.id,
      content: params[:content]
      )

    #画像の保存処理
    if params[:image_name]
      time= DateTime.now
      @photo.image_name = time.strftime("%Y %-m %-d %-H %-M %-S") + ".jpg"
      image = params[:image_name]
    
      File.binwrite("public/post_images/#{@photo.image_name}",image.read)
    end

    #保存処理
    if @photo.save
      redirect_to(root_path)
    else
      #失敗した場合、情報を保持したまま画像遷移させない
      render("/photos/post_form")
    end
  end

  def post_form
    @photo =Photo.new
  end

  #一覧画面の表示
  def view
    #ransack
    @q = Photo.ransack(params[:q])
    @ask = @q.result(distinct: true)

    #ページング(作成日時の降順に表示させるよう修正の必要あり)
    @photos = Photo.page(params[:page]).per(PER)
  end

  #投稿の削除
  def post_destroy
    @photo = Photo.find_by(id:params[:id])
    #投稿を削除
    @photo.destroy

    flash[:notice] = "Post Deleted"
    redirect_to(root_path)
  end

  private
  def post_params
    params.require(:photo).permit(:content)
  end
end
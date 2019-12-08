class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  def index
    @photos = Photo.all
    @photo = Photo.new
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
    #@photo = Photo.new(post_params)
    #@photo.user_id = current_user.id
    #if @photo.save
    #  redirect_back(fallback_location: root_path)
    #else
    #  redirect_back(fallback_location: root_path)
    #end
  end

  def post_form
    @photo =Photo.new
  end

  private
  def post_params
    params.require(:photo).permit(:content)
  end
end

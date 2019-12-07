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
    @photo = Photo.new(post_params)
    @photo.user_id = current_user.id
    if @photo.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def post_params
    params.require(:photo).permit(:content)
  end
end

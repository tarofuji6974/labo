class FavoritesController < ApplicationController
    PER = 10  #投稿の表示数

    def create
    @fav = current_user.favorites.create(photo_id: params[:photo_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @fav = Favorite.find_by(photo_id: params[:photo_id], user_id: current_user.id)
    @fav.destroy
    redirect_back(fallback_location: root_path)
  end

  def view
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id)
    #ページング(作成日時の降順に表示させるよう修正の必要あり)
    @fav = Favorite.page(params[:page]).per(PER)
  end
end

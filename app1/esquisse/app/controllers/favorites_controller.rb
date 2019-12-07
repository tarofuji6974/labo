class FavoritesController < ApplicationController
    def create
    @fav = current_user.favorites.create(photo_id: params[:photo_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @fav = Favorite.find_by(photo_id: params[:photo_id], user_id: current_user.id)
    @fav.destroy
    redirect_back(fallback_location: root_path)
  end
end

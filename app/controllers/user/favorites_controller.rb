class User::FavoritesController < ApplicationController
  def create
    sneaker = Sneaker.find(params[:sneaker_id])
    @favorite = current_user.favorites.new(sneaker_id: sneaker.id)
    @favorite.save
    render 'replace_btn'
  end

  def destroy
    sneaker = Sneaker.find(params[:sneaker_id])
    @favorite = current_user.favorites.find_by(sneaker_id: sneaker.id)
    @favorite.destroy
    render 'replace_btn'
  end
end

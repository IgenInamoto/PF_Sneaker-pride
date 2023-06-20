class User::FavoritesController < ApplicationController
  before_action :authenticate_user!
  # ゲストユーザーとしてログインした場合は閲覧を制限する
  before_action :guest_check
  
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

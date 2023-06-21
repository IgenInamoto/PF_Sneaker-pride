class User::SneakersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] #ログインしているユーザーのみ情報編集出来るようにする。
  # ゲストユーザーとしてログインした場合は閲覧を制限する
  # before_action :guest_check, only: [:new, :create, :update, :destroy]

  
  def new
    @sneaker = Sneaker.new
  end

  def index
    @sneakers = Sneaker.page(params[:page])
    @sneaker = Sneaker.new
    @sneaker_comment = SneakerComment.new
  end

  def show
    @sneaker = Sneaker.find(params[:id])
    @sneaker_comment = SneakerComment.new
  end
  
  def edit
    
  end
  
  def create
    @sneaker = Sneaker.new(sneaker_params)
    @sneaker.user_id = current_user.id
    if @sneaker.save
         flash[:notice] = "You have created book successfully."
      redirect_to sneaker_path(@sneaker.id)
    else
      render "index"
    end
  end
  
  def update
    if @sneaker.update(sneaker_params)
        flash[:notice] = "You have updated book successfully."
      redirect_to sneaker_path(@sneaker)
    else
      render "edit"
    end
  end
  
  def destroy
    @sneaker.destroy
    redirect_to sneakers_path
  end
  
  private
  
  def sneaker_params
     params.require(:sneaker).permit(:title, :body, :image)
  end
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
  def ensure_correct_user
    @sneaker = Sneaker.find(params[:id])
    unless @sneaker.user == current_user
      redirect_to sneakers_path
    end
  end
  
end

class User::SneakersController < ApplicationController
  def new
    @sneaker = Sneaker.new
  end

  def index
    @user = current_user
    @sneakers = Sneaker.all
    @sneaker = Sneaker.new
  end

  def show
    @sneaker = Sneaker.find(params[:id])
    # @user = @Sneaker.user
    @sneaker_new = Sneaker.new
    # @sneaker_comment = SneakerComment.new
  end
  
  def edit
    @sneaker = Sneaker.find(params[:id])
    if @sneaker.user == current_user
      render "edit"
    else
      redirect_to sneakers_path
    end
  end
  
  def create
    @sneaker = Sneaker.new(sneaker_params)
    @sneaker.user_id = current_user.id
    if @sneaker.save
         flash[:notice] = "You have created book successfully."
      redirect_to sneaker_path(@sneaker.id)
    else
      @user = current_user
      @sneakers = Sneaker.all
      render :index
    end
  end
  
  def update
    @sneaker = Sneaker.find(params[:id])
    @sneaker.user_id = current_user.id
    if @sneaker.update(sneaker_params)
        flash[:notice] = "You have updated book successfully."
      redirect_to sneaker_path(@sneaker.id)
    else
      render "edit"
    end
  end
  
  def destroy
    @sneaker = Sneaker.find(params[:id])
    @sneaker.destroy
    redirect_to sneakers_path
  end
  
  private
  
  def sneaker_params
     params.require(:sneaker).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
end

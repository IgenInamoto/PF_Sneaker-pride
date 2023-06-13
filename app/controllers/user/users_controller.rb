class User::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    
    def new
        @user = User.new
    end
    
    def index
        @users = User.all
        @sneaker = Sneaker.new
    end
    
    def show
        @user = User.find(params[:id])
        @sneaker = Sneaker.new
        @sneakers = @user.sneakers
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
           flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user)
        else
            render "edit"
        end
    end
    
    def destroy
        
    end
    
    private
    
    def sneaker_params
        params.require(:sneaker).permit(:title, :body)
    end
    
    def user_params
        params.require(:user).permit(:name,:introduction, :profile_image)
    end
    
    def ensure_correct_user
        @user = User.find(params[:id])
        unless @user == current_user
          redirect_to user_path(current_user)
        end
    end
    
end

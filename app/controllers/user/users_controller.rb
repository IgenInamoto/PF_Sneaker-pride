class User::UsersController < ApplicationController
    
    def new
        @user = User.new
    end
    
    def index
        @user = current_user
        @users = User.all
        @sneakers = Sneaker.all
        @sneaker = Sneaker.new
    end
    
    def show
        @user = User.find(params[:id])
        @sneaker = Sneaker.new
        @sneakers = @user.sneaker
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        
    end
    
    def destroy
        
    end
    
    private
    
    def sneaker_params
        params.require(:sneaker).permit(:title, :body)
    end
    
    def user_params
        params.require(:user).permit(:name,:introduction)
    end
    
end

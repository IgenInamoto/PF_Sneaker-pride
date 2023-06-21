class Admin::SneakersController < ApplicationController
     before_action :authenticate_admin!
    
    def show
         @sneaker = Sneaker.find(params[:id])
         @sneakers = Sneaker.page(params[:page])
    end
    
    def index
         @sneakers = Sneaker.page(params[:page])
    end
    
    def destroy
        sneaker = Sneaker.find(params[:id])
        @user = sneaker.user
        sneaker.destroy
        redirect_to admin_user_path(@user)
    end
    
end

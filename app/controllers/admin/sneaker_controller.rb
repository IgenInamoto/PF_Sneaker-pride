class Admin::SneakerController < ApplicationController
    
    def show
        @sneaker = Sneaker.find(params[:id])
    end
    
    def destroy
        sneaker = Sneaker.find(params[:id])
        @user = sneaker.user
        sneaker.destroy
        redirect_to admin_user_path(@user)
    end
    
end

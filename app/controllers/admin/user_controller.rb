class Admin::UserController < ApplicationController
    
    def index
        @users = User.page(params[:page])
    end
    
    def show
        @user = User.find(params[:id])
        @sneaker = @user.snekaers
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "ユーザーを削除しました。"
        redirect_to admin_users_path
    end
    
end

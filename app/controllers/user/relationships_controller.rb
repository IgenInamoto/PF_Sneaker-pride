class User::RelationshipsController < ApplicationController
    before_action :authenticate_user!
    # ゲストユーザーとしてログインした場合は閲覧を制限する
    # before_action :guest_check, only: [:create, :destroy, :followings, :followers]

    
    def create
        user = User.find(params[:user_id])
        current_user.follow(user)
        redirect_to request.referer
    end
    
    def destroy
        user = User.find(params[:user_id])
        current_user.unfollow(user)
        redirect_to request.referer
    end
    
    def followings
        user = User.find(params[:user_id])
        @users = user.followings
    end
    
    def followers
        user = User.find(params[:user_id])
        @users = user.followers
    end
    
end

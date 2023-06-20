class User::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update] #ログインしているユーザーのみ情報編集出来るようにする。
    # ゲストユーザーとしてログインした場合は閲覧を制限する
    # before_action :guest_check, only: [:update, :withdrawal]
    # before_action :ensure_guest_user, only: [:edit]#before_actionでeditアクション実行前に処理を行う
  

    def new
        @user = User.new
    end
    
    def index
        @users = User.page(params[:page])
        @sneaker = Sneaker.new
    end
    
    def show
        @user = User.find(params[:id])
        @sneaker = Sneaker.new
        @sneakers = @user.sneakers.page(params[:page])
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
    

    def withdrawal
        @user = User.find(params[:id])
        # is_deletedカラムをtrueに変更することにより削除フラグを立てる
        @user.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    end

    
    private
    
    def sneaker_params
        params.require(:sneaker).permit(:title, :body, :image)
    end
    
    def user_params
        params.require(:user).permit(:name,:introduction, :profile_image, :guest_check)
    end
    
    def ensure_correct_user
        @user = User.find(params[:id])
        unless @user == current_user
          redirect_to user_path(current_user)
        end
    end
    
    def ensure_guest_user
        @user = User.find(params[:id])
        if @user.name == "guestuser"
          redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
        end
    end  
    
end

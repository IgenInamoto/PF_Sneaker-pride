# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :reject_inactive_user, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_in_path_for(resource)
    user_path(current_user.id)
    end
  
    def after_sign_out_path_for(resource)
    root_path
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  
  # 退会処理を行った会員が、同じアカウントでログイン出来ないようにする。
  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        redirect_to new_user_session_path
      end
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

class User::SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        @range = params[:range] #検索モデル→params[:range]
        @word = params[:word] #検索ワード→params[:word]

        if @range == "User"
          @users = User.looks(params[:search], params[:word]) #検索方法→params[:search]
          render "user/searches/search_result"
        else
          @sneakers = Sneaker.looks(params[:search], params[:word])
          render "user/searches/search_result"
        end
    end
end

# looksメソッドを使い、検索内容を取得し、変数に代入する
# 検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索し、
# 1：インスタンス変数@usersにUserモデル内での検索結果を代入。
# 2：インスタンス変数@booksにBookモデル内での検索結果を代入。
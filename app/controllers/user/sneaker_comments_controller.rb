class User::SneakerCommentsController < ApplicationController
    
    def create
        @sneaker = Sneaker.find(params[:sneaker_id])
        @user = @sneaker.user
        @sneaker_comment = current_user.sneaker_comments.new(sneaker_comment_params)
        @sneaker_comment.sneaker_id = @sneaker.id
        @sneaker_comment.save
    end
    
    
    def destroy
         @sneaker_comment = SneakerComment.find(params[:id]).destroy
         @sneaker_comment.destroy
         @sneaker = Sneaker.find(params[:sneaker_id])
    end
    
     private

  def sneaker_comment_params
    params.require(:sneaker_comment).permit(:comment)
  end
    
    
end

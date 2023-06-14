class User::SneakerCommentsController < ApplicationController
    
    def create
        sneaker = Sneaker.find(params[:sneaker_id])
        @comment = current_user.sneaker_comments.new(sneaker_comment_params)
        @comment.sneaker_id = sneaker.id
        @comment.save
    end
    
    
    def destroy
         @comment = SneakerComment.find(params[:id])
         @comment.destroy
    end
    
     private

  def sneaker_comment_params
    params.require(:sneaker_comment).permit(:comment)
  end
    
    
end

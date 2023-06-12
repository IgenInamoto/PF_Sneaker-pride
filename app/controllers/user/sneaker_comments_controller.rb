class User::SneakerCommentsController < ApplicationController
    
    def create
        @book = Book.find(params[:book_id])
        @user = @book.user
        @book_comment = current_user.book_comments.new(book_comment_params)
        @book_comment.book_id = @book.id
        @book_comment.save
        # redirect_to book_path(@book)
    end
    
    
    def destroy
         @book_comment = BookComment.find(params[:id]).destroy
         @book_comment.destroy
         @book = Book.find(params[:book_id])
        # redirect_to request.referer
    end
    
     private

  def sneaker_comment_params
    params.require(:sneaker_comment).permit(:comment)
  end
    
    
end

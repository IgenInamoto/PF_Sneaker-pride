class Admin::SneakerCommentsController < ApplicationController
    
    def destroy
        SneakerComments.find(params[:id]).destroy
        redirect_to admin_snekaer_path(params[:sneaker_id])
    end
    
end

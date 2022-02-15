class SearchController < ApplicationController
  def search  
    unless params[:query].blank?  
      @posts = Post.search( params[:query] )  
    end 
  end
end

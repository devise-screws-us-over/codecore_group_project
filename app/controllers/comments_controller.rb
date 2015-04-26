class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @idea = Idea.find(params[:idea_id])
    @comment.idea = @idea

    if @comment.save
      respond_to do |format|
        format.html { redirect_to idea_path(@idea), notice: "Comment Successfully Created" }  
        format.js { render }
      end   
    else
      format.html { render "ideas/show" }
      format.js   { render }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end

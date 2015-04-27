class IdeasController < ApplicationController
    before_action :authenticate_user!
    respond_to :html, :json

  def index
      @ideas = current_user.ideas.all
  end


  def new  
    @idea = Idea.new
  end


  def create
    @idea = current_user.ideas.new(idea_params)
    if @idea.save
      redirect_to @idea, notice: "Idea Created"
    else
      render :new
      flash[:alert] = "Idea Not Created =("
    end  
  end

  def show
    @idea = Idea.find(params[:id])   
    @comment = Comment.new
  end


  def edit
    @idea = current_user.ideas.find(params[:id])
    redirect_to root_path, alert: "access denied" unless can? :manage, @idea
  end


  def update
    @idea = current_user.ideas.find(params[:id])
    @idea.update(idea_params)
      respond_with @idea
  end
  
  # def update
  #   @idea = current_user.ideas.find(params[:id])
  #   if @idea.update(idea_params)
  #     redirect_to @idea, notice: "Idea Updated Successfully!"
  #   else
  #     render :edit
  #     flash[:alert] = "Idea not updated"
  #   end
  # end


  def destroy
    @idea = current_user.ideas.find(params[:id])
    redirect_to root_path, alert: "access denied" unless can? :manage, @idea

    respond_to do |format|
      @idea.destroy
      format.html { redirect_to root_path }
      format.js { render }
    end
  end
  

  private


  def idea_params
    params.require(:idea).permit(:title, :body, {team_ids: []})
  end


end

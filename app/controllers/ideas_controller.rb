class IdeasController < ApplicationController
    before_action :authenticate_user!

  def index
    if current_user
      @ideas = current_user.ideas.all
    else
      @ideas = Idea.all
    end
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
  end


  def update
    @idea = current_user.ideas.find(params[:id])
    if @idea.update(idea_params)
      redirect_to @idea, notice: "Idea Updated Successfully!"
    else
      render :edit
      flash[:alert] = "Idea not updated"
    end
  end


  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    redirect_to root_path
  end


  private


  def idea_params
    params.require(:idea).permit(:title, :body, {team_ids: []})
  end


end

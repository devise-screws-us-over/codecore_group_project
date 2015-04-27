class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end


  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    user = @profile.user
    @profile.handle = "@#{user.first_name}_#{user.last_name}" 
    if @profile.save
      redirect_to root_path, notice: "Profile Sucessfully Created"
    else
      render :new
      flash[:alert] = "Profile not created successfully"
    end
  end

  def edit
    @profile = Profile.find(params[:id])    
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.user = current_user
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Profile Successfully Created"
    else
      render :edit
      flash[:alert] = "Profile Not Updated"
    end
  end

  def show
    @profile = Profile.find(params[:id])
    #start by showing the teams specific to the profile being
    #viewed.  Will then iterate over this in the view to only pull
    #the ideas that belong to a team that the current_user belongs
    #to
    @ideas = @profile.user.ideas
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :facebook, :twitter, :github, :handle, :avatar_url)
  end
  

end

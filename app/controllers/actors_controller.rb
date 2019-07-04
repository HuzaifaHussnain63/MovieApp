class ActorsController < ApplicationController
  before_action :authenticate_admin, except: [:show]

  def index
    @actors = Actor.all
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)
    if @actor.save
      redirect_to actor_path(@actor)
    else
      render 'new'
    end
  end

  def destroy
    @actor = Actor.find(params[:id])
    if @actor.destroy()
      redirect_to actors_path
    else
      flash[:danger] = "Could not delete the actor"
      redirect_to actor_path(@actor)
    end
  end

  def edit
    @actor = Actor.find(params[:id])
  end

  def update
    @actor = Actor.find(params[:id])
    if @actor.update(actor_params)
      redirect_to actor_path(@actor)
    else
      render 'edit'
    end
  end

  def show
    @actor = Actor.find(params[:id])
  end

  private
  def actor_params
    params.require(:actor).permit(:name, :picture)
  end

  def authenticate_admin
    return true if user_signed_in? && current_user.admin?
    flash[:alert] = "You need to be admin to access this section"
    redirect_to home_index_path
  end
end

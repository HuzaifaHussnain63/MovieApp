class ActorsController < ApplicationController
  before_action :authenticate_admin, except: [:show]
  before_action :set_actor, except: [:index, :new, :create]

  def index
    @actors = Actor.order(:name).page params[:page]
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)

    if @actor.save
      flash[:notice] = 'Successfully created an actor.'
      redirect_to actors_path
    else
      render 'new'
    end
  end

  def destroy
    if @actor.destroy
      flash[:notice] = 'Successfully deleted an actor.'
      redirect_to actors_path
    else
      flash[:danger] = 'Could not delete the actor. Try Again.'
      redirect_to actor_path(@actor)
    end
  end

  def edit
  end

  def update
    if @actor.update(actor_params)
      flash[:notice] = 'Successfully updated actor details.'
      redirect_to actors_path
    else
      render 'edit'
    end
  end

  private
  def actor_params
    params.require(:actor).permit(:name, :picture)
  end

end

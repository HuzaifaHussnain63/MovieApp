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
      redirect_to actor_path(@actor)
    else
      render 'new'
    end

  end

  def destroy
    if @actor.destroy
      redirect_to actors_path
    else
      flash[:danger] = 'Could not delete the actor'
      redirect_to actor_path(@actor)
    end
  end

  def edit
  end

  def update
    if @actor.update(actor_params)
      redirect_to actors_path
    else
      render 'edit'
    end
  end

  def show
  end

  private
  def actor_params
    params.require(:actor).permit(:name, :picture)
  end

end

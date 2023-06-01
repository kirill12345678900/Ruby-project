class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index

  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = 'Event was successfully created.'
      redirect_to events_path
    else
      flash[:error] = 'Please fill all fields correctly.'
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:success] = 'Item was updated'
      redirect_to users_path
    else
      flash[:error] = 'Please fill all fields correctly'
      redirect_to users_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = 'Item was successfully destroyed'
      redirect_to users_path
    else
      flash[:error] = 'Failed to destroy item'
      redirect_to users_path
    end
  end


  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :user_id, :category_id)
  end
end

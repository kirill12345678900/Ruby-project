require 'geocoder'

class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @weather = get_weather
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

  def search
    @user = current_user
    @events = if params[:search_term]
                @user.events.where("name LIKE ?", "%#{params[:search_term]}%")
              else
                @user.events
              end
  end

  def search_by_category
    @user = current_user
    if params[:search_term]
      @events = @user.events.joins(:category).where("categories.name LIKE ?", "%#{params[:search_term]}%")
    else
      @events = @user.events
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description, :user_id, :category_id)
  end

  def get_weather
    api_key = 'fc5c5b79bb4822c5f03b82a3a926b1fe'
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=minsk&appid=#{api_key}")
    if response.code == 200
      weather_data = JSON.parse(response.body)
      return weather_data
    end
  end

end
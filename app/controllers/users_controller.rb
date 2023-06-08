require 'kaminari'

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @user = current_user
    @events = Event.where(user_id: current_user.id)
    @paginated_events = @events.page(params[:page]).per(5)
    @upcoming_events_count = Event.where("date > ?", Date.today).count
    @today_events_count = Event.where(date: Date.today).count
  end
end
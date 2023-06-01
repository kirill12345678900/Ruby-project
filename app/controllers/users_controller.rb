class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def index
    @user = current_user
    @upcoming_events_count = Event.where("date > ?", Date.today).count
    @today_events_count = Event.where(date: Date.today).count
  end
end

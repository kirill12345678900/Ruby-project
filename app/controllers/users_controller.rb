require 'kaminari'

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @user = current_user
    @events = Event.where(user_id: current_user.id)

    if params[:search].present?
      @events = @events.where('name ILIKE ?', "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @events = @events.joins(:category).where(categories: { name: params[:category_id] })
    end

    @paginated_events = @events.page(params[:page]).per(5) # Используем пагинацию Kaminari

    @upcoming_events_count = @events.where("date > ?", Date.today).count
    @today_events_count = @events.where(date: Date.today).count

    @categories = Category.all
  end
end
class EventsController < ApplicationController

  respond_to :html, :json

  def new
    @event = Event.new
    @events = Event.all
    @boards = Board.all
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event Created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def index
    @events = Event.all
    @boards = Board.all
  end

  def edit
    @event = Event.find(params[:event_id])
    respond_modal_with @event
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Events updated"
      redirect_to @event.board
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
    @board = @event.board
  end

  def destroy
    @event ||= Event.find(params[:id])
    @event.destroy
    flash[:success] = "Event deleted!"
    redirect_to root_url
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :repeater, :completed,
                                    :tags, :start_date, :deadline, :board_id,
                                    :user_id)
    end

end

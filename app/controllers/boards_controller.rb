class BoardsController < ApplicationController

  def new
    @boards = Board.all
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = "Board Created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def index
    @boards = Board.all
  end

  def detail
    @board_user_relation = BoardUserRelation.new
    @boards = Board.all
    @board = Board.find(params[:id])
    session[:board_id] = @board.id
    cookies[:board_id] = @board.id
    @events = @board.events
    @users = @board.board_user_relations
  end

  def show
    @boards = Board.all
    @board = Board.find(params[:id])
    session[:board_id] = @board.id
    cookies[:board_id] = @board.id
    # Define current or searched date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    # Paginate by week
    @events = @board.events.where(start_date:
      (@date.beginning_of_week)..@date.advance(days: 7).beginning_of_week
    ).or(@board.events.where(deadline:
      (@date.beginning_of_week)..@date.advance(days: 7).beginning_of_week
      ))
    @events_by_date = @events.group_by(&:start_date)
    # Filter duplicate tags
    @events_by_tags = []
    @events.each do |f|
      f.tags.split.each do |x|
       @events_by_tags.push(x.downcase)
      end
    end
    @events_by_tags = @events_by_tags.to_set.to_a
  end

  def destroy
    @board.destroy
    flash[:success] = "Board deleted!"
    redirect_to root_url
  end

  private
    def board_params
      params.require(:board).permit(:title, :user_id)
    end



end

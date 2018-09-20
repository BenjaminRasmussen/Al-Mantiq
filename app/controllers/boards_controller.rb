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
    @events = @board.events
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

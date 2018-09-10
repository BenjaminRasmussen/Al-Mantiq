class BoardController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = "Board Created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @board.destroy
    flash[:success] = "Micropost deleted!"
    redirect_to root_url
  end

  private
    def board_params
      params.require(:board).permit(:title)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end

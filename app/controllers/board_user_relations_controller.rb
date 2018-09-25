class BoardUserRelationsController < ApplicationController

  respond_to :html, :json

  def create
    @board = Board.find(board_user_relation_params[:board_id])
    @user = User.find_by(email: board_user_relation_params[:user_id])
    @userrel = BoardUserRelation.create!(board_id: @board.id,
                                         user_id: @user.id)
    if @userrel.save
      flash[:success] = "Board Created!"
      redirect_to board_path(@board)
    else
      render 'static_pages/home'
    end
  end

  def edit
    @BoardUserRelation = BoardUserRelation.new
    respond_modal_with @BoardUserRelation
  end

  def show
    @board_user_relation = BoardUserRelation.find(params[:id])
  end

  def destroy
    @board_user_relation = BoardUserRelation.find(params[:id])
    @board_user_relation.destroy
    flash[:success] = "User remvoed from board"
    redirect_to root_url
  end

  def update
    @board_user_relation = BoardUserRelation.find(params[:id])
    @board_user_relation.user_id = User.find_by(email: board_user_relation_params[:user_id]).id
    @board_user_relation.board_id = board_user_relation_params[:board_id]
    @board_user_relation.admin = board_user_relation_params[:admin]
    if @board_user_relation.save!
    flash[:success] = "BoardUserRelation updated"
    redirect_to @board_user_relation.board
    else
      render 'edit'
    end
  end

  def current_resource
    @current_resource ||= BoardUserRelation.find(params[:f]) if params[:f]
  end

  private
    def board_user_relation_params
      params.require(:board_user_relation).permit(:user_id, :board_id, :admin)
    end

end

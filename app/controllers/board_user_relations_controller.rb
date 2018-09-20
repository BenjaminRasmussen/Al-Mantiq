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
    @boards = Board.all
    @board_user_relation = BoardUserRelation.find(params[:id])
  end

  def destroy
    @board_user_relation = BoardUserRelation.find(params[:id])
    @board_user_relation.destroy
    flash[:success] = "User remvoed from board"
    redirect_to root_url
  end

  def update
    @board_user_relation = BoardUserRelation.find_by(user_id: params[:user_id],
                                                     board_id: params[:board_id])
    if @board_user_relation.update_attributes(board_user_relation_params)
      flash[:success] = "BoardUserRelation updated"
      redirect_to @board_user_relation
    else
      render 'edit'
    end
  end

  private
    def board_user_relation_params
      params.require(:board_user_relation).permit(:user_id, :board_id, :admin)
    end

end

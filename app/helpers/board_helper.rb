module BoardHelper
  def last_board
    @last_board ||= session[:board_id]
  end
end

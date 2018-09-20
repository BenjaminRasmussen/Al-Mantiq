class StaticPagesController < ApplicationController
  include SessionsHelper

  def home
    @boards = Board.all
    if logged_in?
    else
      redirect_to login_url
    end
  end
end

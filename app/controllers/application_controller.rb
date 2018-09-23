class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout "layouts/application"
  include SessionsHelper

  @boards = Board.all

  
  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

end

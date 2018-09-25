class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout "layouts/application"
  include SessionsHelper

  before_action :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?


  private

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def current_resource
      nil
    end

    def authorize
      if current_permission.allow?(params[:controller], params[:action], current_resource)
        current_permission.permit_params! params
      else
        if current_user
          redirect_to root_url, alert: "not authorized"
        else
          redirect_to login_path
        end
      end
    end

    def respond_modal_with(*args, &blk)
      options = args.extract_options!
      options[:responder] = ModalResponder
      respond_with *args, options, &blk
    end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    if !session[:user_id].nil?
      @current_user ||= User.where(id: session[:user_id]).first
    end
  end
end

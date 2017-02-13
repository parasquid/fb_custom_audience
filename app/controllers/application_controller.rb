class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    if !session[:user_id].nil?
      @current_user ||= User.where(id: session[:user_id]).first
    end
  end

  def graph
    if current_user
      token = current_user.token
      graph = Koala::Facebook::API.new(token)
    else
      raise "User is not logged in"
    end
  end
end

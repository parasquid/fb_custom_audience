class LoggedInController < ApplicationController
  before_action :require_login

  def require_login
    if current_user.nil?
      redirect_to root_url
    end
  end

end

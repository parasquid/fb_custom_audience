class HomeController < ApplicationController
  def index
    if current_user
      redirect_to ad_accounts_path
    end
  end
end

class SessionsController < ApplicationController
  def create
  	if params[:provider] == "facebook"
      auth_hash = request.env["omniauth.auth"]
      provider = auth_hash["provider"]
      uid = auth_hash["uid"]
      token = auth_hash["credentials"]["token"]

      authentication = Authentication.where(provider: provider, uid: uid).first
      if authentication
        user = authentication.user
        session[:user_id] = user.id
      else
        user = User.create
        authentication = user.authentications.create(provider: provider, uid: uid)
      end

      authentication.token = token
      authentication.save
    end

    redirect_to original_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_back fallback_location: root_url, notice: "Signed out!"
  end

  private

  def original_url
    request.env['omniauth.origin'] || root_url
  end
end

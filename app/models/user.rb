class User < ApplicationRecord
  has_many :authentications

  def most_recent_authentication
    authentications.order(updated_at: :desc).first
  end

  def token
    most_recent_authentication.token
  end
end

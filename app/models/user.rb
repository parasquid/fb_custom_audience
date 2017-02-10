class User < ApplicationRecord
  has_many :authentications
  has_many :custom_audiences

  def most_recent_authentication
    authentications.order(updated_at: :desc).first
  end

  def token
    most_recent_authentication.token
  end
end

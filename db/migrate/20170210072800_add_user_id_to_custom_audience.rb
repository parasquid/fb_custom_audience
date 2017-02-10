class AddUserIdToCustomAudience < ActiveRecord::Migration[5.0]
  def change
    add_reference :custom_audiences, :user, foreign_key: true
  end
end

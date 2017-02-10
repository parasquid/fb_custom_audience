class CustomAudience < ApplicationRecord
  has_many :workflows
  belongs_to :user

  def workflow_ids
    workflows.pluck(:mp_id)
  end
end

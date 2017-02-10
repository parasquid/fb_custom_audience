class CustomAudience < ApplicationRecord
  has_many :workflows

  def workflow_ids
    workflows.pluck(:mp_id)
  end
end

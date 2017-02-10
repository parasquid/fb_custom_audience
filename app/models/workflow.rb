class Workflow < ApplicationRecord
  belongs_to :custom_audience

  def custom_audience_id
    custom_audience.id
  end
end

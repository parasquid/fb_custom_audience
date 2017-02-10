class CreateCustomAudienceToWorkflowLuts < ActiveRecord::Migration[5.0]
  def change
    create_table :custom_audience_to_workflow_luts do |t|
      t.string :custom_audience_id
      t.string :workflow_ids

      t.timestamps
    end
  end
end

class CreateJoinTableArtifactsEvents < ActiveRecord::Migration
  def change
    create_join_table :artifacts, :events do |t|
      # t.index [:artifact_id, :event_id]
      # t.index [:event_id, :artifact_id]
    end
  end
end

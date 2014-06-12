class CreateJoinTableArtifactPhoto < ActiveRecord::Migration
  def change
    create_join_table :artifacts, :photos do |t|
      # t.index [:artifact_id, :photo_id]
      # t.index [:photo_id, :artifact_id]
    end
  end
end

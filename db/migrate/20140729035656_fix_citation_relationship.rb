class FixCitationRelationship < ActiveRecord::Migration
  def change
    rename_column :citations, :artifact_id, :event_id
  end
end

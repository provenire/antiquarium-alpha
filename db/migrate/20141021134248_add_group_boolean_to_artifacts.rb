class AddGroupBooleanToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :group, :boolean, default: false
    add_index  :artifacts, :group
  end
end

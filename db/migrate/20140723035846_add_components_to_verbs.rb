class AddComponentsToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :components, :string, array: true, default: '{date,failed,details}'
  end
end

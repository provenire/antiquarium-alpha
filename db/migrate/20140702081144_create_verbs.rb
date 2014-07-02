class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :display
      t.string :keyword
    end
  end
end

class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :actor, polymorphic: true
      t.references :event
      
      t.boolean :recipient,     null: false, default: true
      t.boolean :unknown_actor, null: false, default: false
      
      t.timestamps
    end
  end
end

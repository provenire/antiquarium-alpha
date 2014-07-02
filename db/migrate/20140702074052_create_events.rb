class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.uuid    :uuid,    null: false
      t.date    :date
      t.string  :verb,    null: false, default: "unknown"
      t.text    :details
      t.boolean :failed,  null: false, default: false
      t.string  :price
      
      t.timestamps
    end
  end
end

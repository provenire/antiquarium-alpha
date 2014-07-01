class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.uuid   :uuid,        null: false, index: true
      t.string :name,        null: false
      t.text   :description
      
      t.timestamps
    end
  end
end

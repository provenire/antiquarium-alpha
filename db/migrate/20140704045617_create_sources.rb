class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.uuid   :uuid,        null: false, unique: true
      t.string :name,        null: false
      t.text   :description
      t.string :status,      null: false, default: 'ready'
      
      t.string :thumbnail
      t.string :document
      
      t.string :type
      t.hstore :specifics

      t.timestamps
    end
  end
end

class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.uuid   :uuid,            null:  false, index: true
      t.string :name,            null:  false, index: true
      t.string :alternate_names, array: true
      t.text   :description
      
      t.string :artist
      t.string :dimensions
      t.string :date_created
      
      t.timestamps
    end
  end
end

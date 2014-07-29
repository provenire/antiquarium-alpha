class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.references :artifact
      t.references :source
      
      t.text :content

      t.timestamps
    end
  end
end

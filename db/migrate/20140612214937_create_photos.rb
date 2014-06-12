class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.text   :comments
      t.timestamps
    end
  end
end

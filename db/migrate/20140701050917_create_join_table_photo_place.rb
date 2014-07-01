class CreateJoinTablePhotoPlace < ActiveRecord::Migration
  def change
    create_join_table :photos, :places do |t|
      # t.index [:photo_id, :place_id]
      # t.index [:place_id, :photo_id]
    end
  end
end

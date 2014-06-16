class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.uuid   :uuid,        null: false, index: true, unique: true
      t.string :name,        null: false, index: true
      t.text   :description
      t.string :gender,      null: false, default: 'unknown'
      t.date   :date_of_birth
      t.date   :date_of_death
      t.string :nationality, null: false, default: 'unknown'
      
      t.timestamps
    end
  end
end

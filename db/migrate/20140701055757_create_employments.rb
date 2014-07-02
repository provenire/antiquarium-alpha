class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.references :person, null: false, index: true
      t.references :place,  null: false, index: true
      
      t.string  :title
      t.date    :start_date
      t.date    :end_date
      t.boolean :current_job
      t.text    :details
      
      t.timestamps
    end
  end
end

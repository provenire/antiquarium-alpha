class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :name, unique: true, default: "no_name"
      t.text   :text
      t.timestamps
    end
    
    PageContent.create(name: 'home_page', text: 'Welcome to Antiquarium!')
  end
end
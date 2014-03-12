class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.string :text
      t.integer :story_id

      t.timestamps
    end
  end
end

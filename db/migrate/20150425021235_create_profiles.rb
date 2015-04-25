class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.text :bio
      t.string :handle
      t.string :facebook
      t.string :twitter
      t.string :github

      t.timestamps null: false
    end
  end
end

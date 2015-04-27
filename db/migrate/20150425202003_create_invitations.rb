class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.string :key
      t.string :recipient
      t.boolean :is_sent
      t.boolean :has_account
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end

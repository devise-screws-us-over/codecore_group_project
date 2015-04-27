class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :idea, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

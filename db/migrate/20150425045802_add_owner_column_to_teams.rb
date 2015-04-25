class AddOwnerColumnToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :owner, :integer
  end
end

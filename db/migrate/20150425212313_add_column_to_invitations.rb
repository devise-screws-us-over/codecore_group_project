class AddColumnToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :array, :string
  end
end

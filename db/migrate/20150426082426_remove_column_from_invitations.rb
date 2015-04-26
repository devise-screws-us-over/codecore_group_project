class RemoveColumnFromInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :is_sent, :string
  end
end

class RenameGroupsIdColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :groups_id, :group_id
    rename_column :messages, :users_id, :user_id
  end
end

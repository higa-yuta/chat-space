class ChangeIndexToGroups < ActiveRecord::Migration[5.2]
  def change
    remove_index :groups, :name
  end
end

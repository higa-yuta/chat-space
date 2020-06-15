class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :text, null: false
      t.string :image
      t.references :users, foreign_key: true
      t.references :groups, foreign_key: true
      t.timestamps
    end
  end
end

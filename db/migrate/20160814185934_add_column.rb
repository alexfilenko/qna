class AddColumn < ActiveRecord::Migration[5.0]
  def change
  change_table :questions do |t|
  t.integer :user_id
end
  end
end

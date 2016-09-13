class AddUserIdToAnswer < ActiveRecord::Migration[5.0]
  def change
     change_table :answers do |t|
       t.belongs_to :user, index: true, foreign_key: { on_delete: :nullify }
    end
  end
end

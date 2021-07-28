class RemoveNicknameFromEmployee < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :nickname, :string
  end
end

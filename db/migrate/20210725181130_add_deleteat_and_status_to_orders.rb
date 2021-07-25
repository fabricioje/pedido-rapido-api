class AddDeleteatAndStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :string
    add_column :orders, :delete_at, :datetime
  end
end

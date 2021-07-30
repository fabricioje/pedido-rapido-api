class AddDeleteatAndStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :integer, default: 0
    add_column :orders, :delete_at, :datetime
  end
end

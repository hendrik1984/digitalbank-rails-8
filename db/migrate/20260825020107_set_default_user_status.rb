class SetDefaultUserStatus < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :status, from: nil, to: "active"
  end
end

class ChangeOrderAttributesToText < ActiveRecord::Migration
  def change
    change_column :orders, :comment, :text
    change_column :orders, :conclusion, :text
  end
end

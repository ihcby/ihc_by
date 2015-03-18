class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date
      t.references :doctor, index: true
      t.references :trial_type, index: true
      t.string :conclusion
      t.string :tracking_number
      t.references :laboratory, index: true
      t.string :comment

      t.timestamps null: false
    end
    add_foreign_key :orders, :doctors
    add_foreign_key :orders, :trial_types
  end
end

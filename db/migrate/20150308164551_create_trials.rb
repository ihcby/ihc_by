class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references :antibody, index: true
      t.references :order, index: true
      t.timestamps null: false
    end
    add_foreign_key :trials, :antibodies
    add_foreign_key :trials, :orders
  end
end

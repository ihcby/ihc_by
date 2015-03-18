class CreateLaboratories < ActiveRecord::Migration
  def change
    create_table :laboratories do |t|
      t.string :name
      t.references :account, index: true

      t.timestamps
    end
  end
end

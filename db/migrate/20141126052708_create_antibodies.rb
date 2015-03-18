class CreateAntibodies < ActiveRecord::Migration
  def change
    create_table :antibodies do |t|
      t.string :name

      t.timestamps
    end
  end
end

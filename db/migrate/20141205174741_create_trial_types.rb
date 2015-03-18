class CreateTrialTypes < ActiveRecord::Migration
  def change
    create_table :trial_types do |t|
      t.string :name
      t.references :laboratory, index: true

      t.timestamps
    end
  end
end

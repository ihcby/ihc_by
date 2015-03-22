class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :trial, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :trials

    add_attachment :pictures, :image
  end

end

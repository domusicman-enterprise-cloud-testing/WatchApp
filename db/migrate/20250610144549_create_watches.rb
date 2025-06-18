class CreateWatches < ActiveRecord::Migration[8.0]
  def change
    create_table :watches do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.decimal :case_diameter
      t.decimal :case_thickness
      t.decimal :lug_width
      t.string :reference_number
      t.string :caliber
      t.string :movement_type
      t.text :features
      t.text :complications
      t.text :description

      t.timestamps
    end
    
    add_index :watches, :brand
    add_index :watches, :model
    add_index :watches, :year
    add_index :watches, :reference_number
    add_index :watches, :caliber
  end
end

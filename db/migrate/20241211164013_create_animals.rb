class CreateAnimals < ActiveRecord::Migration[7.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :species
      t.integer :age

      t.timestamps
    end
  end
end

class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :directions
      t.float :servings
      t.float :energy
      t.float :carbs
      t.float :fiber
      t.float :sugar
      t.float :fat
      t.float :monounsaturated
      t.float :polyunsaturated
      t.float :omega3
      t.float :omega6
      t.float :saturated
      t.float :transfat
      t.float :cholesterol
      t.float :protein
      t.float :vit_b1
      t.float :vit_b2
      t.float :vit_b3
      t.float :vit_b5
      t.float :vit_b6
      t.float :vit_b12
      t.float :biotin
      t.float :choline
      t.float :folate
      t.float :vit_a
      t.float :vit_c
      t.float :vit_d
      t.float :vit_e
      t.float :vit_k
      t.float :calcium
      t.float :chromium
      t.float :copper
      t.float :fluoride
      t.float :iodine
      t.float :iron
      t.float :magnesium
      t.float :manganese
      t.float :molybdenum
      t.float :phosphorus
      t.float :potassium
      t.float :selenium
      t.float :sodium
      t.float :zinc
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateHousings < ActiveRecord::Migration[5.2]
  def change
    create_table :housings do |t|
      t.references :admin, index: true
      t.belongs_to :city, index: true
      t.integer :available_beds
      t.integer :nuity_price
      t.text :description
      t.boolean :has_wifi
      t.text :welcome_message

      t.timestamps
    end
  end
end

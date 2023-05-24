class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end

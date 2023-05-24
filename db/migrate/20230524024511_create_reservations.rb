class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :reservation_code, null: false, unique: true
      t.references :guest, null: false, foreign_key: true

      t.date :start_date
      t.date :end_date

      t.integer :night_count
      t.integer :guest_count
      t.integer :adult_count
      t.integer :children_count
      t.integer :infant_count

      t.string :status
      t.string :currency

      t.decimal :payout_price, precision: 8, scale: 2
      t.decimal :security_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end

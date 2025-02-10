class CreateBorrowings < ActiveRecord::Migration[8.0]
  def change
    create_table :borrowings do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :book,   null: false, foreign_key: true
      t.datetime   :borrowed_at, null: false
      t.datetime   :due_date,    null: false
      t.datetime   :returned_at

      t.timestamps
    end

    # Ensure a book cannot be borrowed if there is an active (unreturned) record.
    add_index :borrowings, :book_id, unique: true, where: "returned_at IS NULL", name: "index_active_borrowings_on_book_id"
  end
end

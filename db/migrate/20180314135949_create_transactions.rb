class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 11, scale: 2
      t.datetime :date
      t.string :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

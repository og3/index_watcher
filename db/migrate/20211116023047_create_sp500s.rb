class CreateSp500s < ActiveRecord::Migration[6.1]
  def change
    create_table :sp500s do |t|
      t.date :date
      t.float :point
      t.float :day_before_ratio
      t.float :day_before_ratio_percent
      t.float :rsi
      t.boolean :noticed, default: 0

      t.timestamps
    end
    add_index :sp500s, :date, unique: true
  end
end

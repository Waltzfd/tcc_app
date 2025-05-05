class CreateDailyFoodLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_food_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :log_date
      t.text :breakfast_details
      t.integer :breakfast_calories
      t.text :lunch_details
      t.integer :lunch_calories
      t.text :snack_details
      t.integer :snack_calories
      t.text :dinner_details
      t.integer :dinner_calories

      t.timestamps
    end
  end
end

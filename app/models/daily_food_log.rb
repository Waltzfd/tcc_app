class DailyFoodLog < ApplicationRecord
  belongs_to :user # Assumindo que você tem um model User

  # Opcional: Validações
  validates :log_date, presence: true
  validates :breakfast_calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :lunch_calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :snack_calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :dinner_calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Opcional: Método para calcular total de calorias do dia
  def total_calories
    (breakfast_calories || 0) +
      (lunch_calories || 0) +
      (snack_calories || 0) +
      (dinner_calories || 0)
  end


end
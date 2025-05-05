class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient


  validates :meal, presence: true
  validates :ingredient, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }


  def total_calories
    # Assume que o `calories` do ingrediente é por uma unidade e 'quantity' usa a mesma unidade
    # Se `ingredient.calories` for por 100g e `quantity` for em gramas, o cálculo seria (ingredient.calories / 100.0) * quantity
    ingredient.calories * quantity if ingredient && quantity.present?
  end
end


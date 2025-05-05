class Ingredient < ApplicationRecord
  #belongs_to :recipe
  # se der problema trocar depois
  has_many :meal_ingredients # Um ingrediente pode estar em muitos itens de refeição
  has_many :meals, through: :meal_ingredients # Acesso indireto às refeições

  #se der problema trocar depois
  validates :name, presence: true
  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

class Recipe < ApplicationRecord
  #has_many :ingredients
  #has_and_belongs_to_many :meals

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  validates :name, presence: true

  def total_calories

    ingredients.sum(&:calories) if ingredients.any? # Assumindo associação direta ou via RecipeIngredient
    0 # Retorna 0 se não houver ingredientes ou a associação não estiver configurada
end
  end
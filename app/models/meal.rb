class Meal < ApplicationRecord
  #belongs_to :user
  #has_and_belongs_to_many :recipes

  # se der problema excluir daqui
  belongs_to :meal_plan
  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients
  accepts_nested_attributes_for :meal_ingredients, reject_if: :all_blank, allow_destroy: true
  # ... resto do model
end

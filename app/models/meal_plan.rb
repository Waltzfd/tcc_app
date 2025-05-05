class MealPlan < ApplicationRecord
  #belongs_to :user
  #has_many :meals

  #se der problema excluir daqui
  has_many :meals, dependent: :destroy
  accepts_nested_attributes_for :meals, reject_if: :all_blank, allow_destroy: true
  # ... resto do model
  #
end

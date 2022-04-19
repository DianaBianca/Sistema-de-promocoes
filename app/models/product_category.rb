# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :product_category_promotions
  has_many :promotions, through: :product_category_promotions, dependent: :destroy

  validates :name, :code, presence: { message: 'não pode ficar em branco' }
  validates :code, uniqueness: { message: 'Código já está em uso' }
end

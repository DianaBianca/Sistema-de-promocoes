# frozen_string_literal: true

class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_many :product_category_promotions, dependent: :delete_all
  has_many :product_categories, through: :product_category_promotions
  validates :name, :code, :discount_rate,
            :coupon_quantity, :expiration_date,
            presence: { message: 'não pode ficar em branco' }
  validates :code, uniqueness: { message: 'Código já está em uso' }
  validates :coupon_quantity, numericality: { greater_than: 0 }

  def generate_coupons!
    return raise 'Cupons já foram gerados' if coupons.any?

    codes =
      (1..coupon_quantity).map do |number|
        { code: "#{code}-#{'%04d' % number}",
          created_at: Time.zone.now, updated_at: Time.zone.now,
          promotion_id: id }
      end
    Coupon.insert_all!(codes)
  end

  def expired?
    Time.zone.today > expiration_date
  end
end

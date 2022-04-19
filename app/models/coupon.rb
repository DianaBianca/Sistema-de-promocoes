# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :promotion

  enum status: { active: 0, burn: 10, inactive: 20 }

  validates :promotion, :code, presence: { message: 'não pode ficar em branco' }

  validates :code, uniqueness: { message: 'já está em uso' }

  def title
    "#{code}(#{Coupon.human_attribute_name("status.#{status}")})"
  end

  def as_json(options = {})
    super({ methods: %i[promotion_id discount_rate expiration_date],
            only: %i[] }.merge(options))
  end

  def burn!
    update!(status: :burn)
  end

  def unavailable?
    promotion.expired? || inactive? || burn?
  end

  def can_be_burned?
    !unavailable?
  end

  private

  def discount_rate
    promotion.discount_rate
  end

  def expiration_date
    I18n.l(promotion.expiration_date)
  end
end

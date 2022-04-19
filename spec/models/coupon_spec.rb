require 'rails_helper'

describe Coupon do
  context 'validation' do
    it  'attributes cannot be blank' do
      coupon = Coupon.new
      coupon.save

      expect(coupon.errors[:promotion]).to include('não pode ficar em branco')
      expect(coupon.errors[:code]).to include('não pode ficar em branco')
    end

    it 'codes must be unique' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL12', discount_rate: 12, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')

      Coupon.create!(promotion: promotion, code: '12312')

      coupon = Coupon.new(code: '12312')
      coupon.save

      expect(coupon.persisted?).to eq(false)
      expect(coupon.errors[:code]).to include('já está em uso')
    end

    it 'successfully' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL12', discount_rate: 12, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')

      coupon = Coupon.new(promotion: promotion, code: '12312')
      coupon.save

      expect(coupon.persisted?).to eq(true)
    end
  end

  context '#title' do
    it 'status default' do
      coupon = Coupon.new(code: 'NATAL10-0001')
      expect(coupon.title).to eq('NATAL10-0001(disponível)')
    end

    it 'status active' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :active)
      expect(coupon.title).to eq('NATAL10-0001(disponível)')
    end

    it 'status inactive' do
      coupon = Coupon.new(code: 'NATAL10-0001', status: :inactive)
      expect(coupon.title).to eq('NATAL10-0001(indisponível)')
    end
  end
end

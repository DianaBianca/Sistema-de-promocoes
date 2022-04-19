require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      promotion.save

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033')
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('Código já está em uso')
    end
  end

  context '#generate_coupons!' do
    it 'of a promotion without coupons' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 3,
                                  expiration_date: '22/12/2033')
      promotion.generate_coupons!

      expect(promotion.coupons.count).to eq(3)
      expect(promotion.coupons.map(&:code)).to contain_exactly(
        'NATAL10-0001', 'NATAL10-0002','NATAL10-0003'
      )
    end

    it 'and coupons already generated' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 3,
                                  expiration_date: '22/12/2033')
      promotion.generate_coupons!

      expect {promotion.generate_coupons!}.to raise_error('Cupons já foram gerados')
      expect(promotion.coupons.count).to eq(3)
      expect(promotion.coupons.map(&:code)).to contain_exactly(
        'NATAL10-0001', 'NATAL10-0002','NATAL10-0003'
      )
    end
  end
end

require 'rails_helper'

describe CouponsController do
  describe '#show', type: :request do
    let(:promotion) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 10,
                                  expiration_date: '22/12/2033')
    end
    let(:promotion_expired) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 10,
                                  expiration_date: '22/12/2010')
    end

    let(:coupon){ Coupon.create!(promotion: promotion, code: 'NATAL12-0001') }
    let(:wrong_coupon){ "WRONG" }

    it 'show coupon successfully' do
      get "/api/v1/coupons/#{coupon.code}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('12')
      expect(response.body).to include('22/12/2033')
    end

    it 'coupon doesnt exist' do
      get "/api/v1/coupons/#{wrong_coupon}"

      expect(response).to have_http_status(404)
      expect(response.body).to include('Este cupom não existe')
    end
  end

  describe '#burn', type: :request do
    let(:promotion) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 2,
                                  expiration_date: '22/12/2033')
    end
    let(:promotion_expired) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 2,
                                  expiration_date: '22/12/2010')
    end

    let(:coupon){ Coupon.create!(promotion: promotion, code: 'NATAL12-0001') }
    let(:coupon_inactive){ Coupon.create!(promotion: promotion, code: 'NATAL12-0002', status: 20) }
    let(:coupon_burned){ Coupon.create!(promotion: promotion, code: 'NATAL12-0002', status: 10) }


    it 'coupon burned successfully' do

      post "/api/v1/coupons/#{coupon.code}/burn"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom queimado com sucesso')
      expect(coupon).to_not be_burn
    end

    it 'coupon cannot burn because it is inactive' do
      post "/api/v1/coupons/#{coupon_inactive.code}/burn"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom não pode ser queimado')
      expect(coupon).to_not be_burn
    end

    it 'coupon cannot burn because it is already burned' do
      post "/api/v1/coupons/#{coupon_burned.code}/burn"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cupom não pode ser queimado')
    end

    it 'coupon not found by code' do
      post "/api/v1/coupons/66666/burn"

      expect(response).to have_http_status(404)
      expect(response.body).to include('Este cupom não existe')
    end
  end

  describe '#validates', type: :request do
    let(:promotion) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 2,
                                  expiration_date: '22/12/2033')
    end
    let(:promotion_expired) do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL12', discount_rate: 12, coupon_quantity: 2,
                                  expiration_date: '22/12/2010')
    end

    let(:coupon){ Coupon.create!(promotion: promotion, code: 'NATAL12-0001') }
    let(:coupon_inactive){ Coupon.create!(promotion: promotion, code: 'NATAL12-0002', status: 20) }

    it 'coupon validate successfully' do
      get "/api/v1/coupons/#{coupon.code}/validates"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Este cupom é válido')
    end

    it 'cannot be invalid' do
      get "/api/v1/coupons/#{coupon_inactive.code}/validates"

      expect(response).to have_http_status(404)
      expect(response.body).to include('Este cupom é inválido')
    end
  end
end

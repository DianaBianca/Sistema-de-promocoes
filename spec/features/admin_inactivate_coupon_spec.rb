require 'rails_helper'

xfeature 'Admin inactivate coupon' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456')
    login_as user, scope: :user
  end

  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL12', discount_rate: 12, coupon_quantity: 1,
                      expiration_date: '22/12/2033')

    coupon = Coupon.create!(promotion: promotion, code: 'NATAL12-0001')

    visit root_path
    click_on 'Promoções', match: :first

    fill_in 'coupon_code', with: 'NATAL12-0001'
    click_button 'Buscar'
    find('.ls-btn-primary-danger').click

    expect(page).to have_content('cancelado')
    expect(page).to_not have_link('Desativar cupom')
    expect(coupon.reload).to be_inactive
  end
end

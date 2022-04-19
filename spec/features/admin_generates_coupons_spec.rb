require 'rails_helper'

xfeature 'Admin generates coupons' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456')
    login_as user, scope: :user
  end

  scenario 'with coupon quantity available' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 3,
                                  expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first

    click_on promotion.name

    click_on 'Emitir cupons'

    expect(current_path).to eq(promotion_path(promotion))

    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to_not have_link('Emitir cupons')
  end

  scenario 'and coupons are already generated' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 3,
                                  expiration_date: '22/12/2033')
    promotion.coupons.create(code:'ABCD')

    visit promotion_path(promotion)

    expect(page).to_not have_link('Emitir cupons')
    expect(page).to have_content(promotion.code)
  end

end

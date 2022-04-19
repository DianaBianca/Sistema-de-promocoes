require 'rails_helper'

xfeature 'Admin registers a valid promotion' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456')

    login_as user, scope: :user
  end
  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Registrar uma promoção'
    click_on 'Criar promoção'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar promoção'

    expect(page).to have_content('Código já está em uso')
  end
end


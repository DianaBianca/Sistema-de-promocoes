require 'rails_helper'

xfeature 'Admin edits a promotion' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456') 
    
    login_as user, scope: :user
  end
  scenario 'and attributes cannot be blank' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Natal'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''

    click_on 'Concluir'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Pascoa', description: 'Promoção de Pascoa',
    code: 'COELHINHO12', discount_rate: 12, coupon_quantity: 100,
    expiration_date: '22/04/2022')

    Promotion.create!(name: 'Cyber Friday', description: 'Promoção de sexta feira',
    code: 'CYBER15', discount_rate: 15, coupon_quantity: 100,
    expiration_date: '22/12/2021')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Pascoa'
    click_on 'Editar'

    fill_in 'Código', with: 'CYBER15'

    click_on 'Concluir'

    expect(page).to have_content('Código já está em uso')
  end

  scenario 'and edits a promotion successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL12', discount_rate: 12, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Natal'
    click_on 'Editar promoção'

    fill_in 'Nome', with: 'Natal12OFF'

    click_on 'Concluir'

    expect(page).to have_content('Edição realizada com sucesso')
  end
end

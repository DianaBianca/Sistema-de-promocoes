require 'rails_helper'

xfeature 'Admin view promotions' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456') 
    
    login_as user, scope: :user
  end

  scenario 'successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first, match: :first

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
  end

  scenario 'and view details' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 5,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit promotions_path
    click_on 'Promoções', match: :first

    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('5')
  end

  scenario 'and no promotion are created' do

    visit root_path
    click_on 'Promoções', match: :first

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  scenario 'and return to home page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to promotions page' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções', match: :first
    click_on 'Natal'
    click_on 'Voltar'

    expect(current_path).to eq promotions_path
  end

  scenario 'and cannot view promotions unless logged in' do
    visit root_path
    click_on 'Sair'

    expect(page).to_not have_link('Promoções')
  end

  scenario ' and cannot view promotions unless logged in via link' do
    visit root_path
    click_on 'Sair'

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    
    visit promotions_path

    expect(page).to_not have_content('Natal')
    expect(page).to_not have_link('Promoções')
    expect(current_path).to eq(new_user_session_path)
  end

  scenario ' and cannot view details unless logged in via link' do
    visit root_path
    click_on 'Sair'

    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    
    visit promotion_path(promotion)

    expect(page).to_not have_link('Natal')
    expect(current_path).to eq(new_user_session_path)

  end
end

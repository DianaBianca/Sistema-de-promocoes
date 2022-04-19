require 'rails_helper'

feature 'Admin view a product categories' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456') 
    
    login_as user, scope: :user
  end
  scenario 'successfully' do
    ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')
    ProductCategory.create!(name: 'Email', code: 'EMAIL')

    visit root_path
    click_on 'Categorias de Produto', match: :first

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
    expect(page).to have_content('Email')
    expect(page).to have_content('EMAIL')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and show empty message' do
    visit root_path
    click_on 'Categorias de Produto', match: :first

    expect(page).to have_content('Nenhuma categoria cadastrada')
    expect(page).to have_link('Voltar', href: root_path)
  end
end
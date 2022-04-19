require 'rails_helper'

feature 'User log in' do
  scenario 'and receive welcome message' do
    User.create!(email: 'diana@luizalabs.com.br', password:'123456')
    visit root_path
    click_on 'Login'

    fill_in 'Email', with: 'diana@luizalabs.com.br'
    fill_in 'Senha', with: '123456'

    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_link('Login')
    expect(page).to have_link('Sair')
  end
  xscenario 'and logout successfully' do
    User.create!(email: 'fulana@luizalabs.com.br', password:'123456')
    visit root_path
    click_on 'Login'

    fill_in 'Email', with: 'fulana@luizalabs.com.br'
    fill_in 'Senha', with: '123456'

    click_on 'Entrar'
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Saiu com sucesso')
    expect(page).to_not have_content('fulana@luizalabs.com.br')
    expect(page).to have_link('Login')
    expect(page).to_not have_link('Sair')
  end
end

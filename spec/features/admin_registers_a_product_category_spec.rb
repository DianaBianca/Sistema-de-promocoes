require 'rails_helper'
xfeature 'Admin registers a new category' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456')

    login_as user, scope: :user
  end
  scenario 'from index page' do
    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_link('Criar Categoria', href: new_product_category_path)
  end

  scenario 'successfully' do
    ProductCategory.create!(name: 'Eletronico', code: 'ELETRO')
    ProductCategory.create!(name: 'Celulares', code: 'CEL')

    visit root_path
    click_on 'Categorias de Produto'

    expect(page).to have_content('Eletronico')
    expect(page).to have_link('Voltar', href: root_path)
  end
end
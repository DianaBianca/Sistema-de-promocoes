# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor visit home page' do
  before(:each) do
    user = User.create!(email: 'fulana@luizalabs.com.br', password:'123456')

    login_as user, scope: :user
  end
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Sistema de Promoções')
  end
end

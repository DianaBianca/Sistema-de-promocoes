require 'rails_helper'

describe User do
  context 'validation' do
    it 'email is not from luizalabs' do
      user = User.new(email: 'juliana@gmail.com', password: '123456')

      user.save

      expect(user.errors[:email]).to include('O e-mail precisa ser @luizalabs.com.br')
    end

    it 'email is correct' do
      user = User.new(email: 'jussara@luizalabs.com.br', password: '123456')

      user.save

      expect(user.errors[:email]).to eq []
    end
  end
end

require 'rails_helper'

describe ProductCategory do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = ProductCategory.new
      product.save

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:code]).to include('não pode ficar em branco')

    end

    it ' product code must be uniq' do
      ProductCategory.create!(name: 'Hospedagem', code: 'HOSP')

      product = ProductCategory.new(code: 'HOSP')
      product.valid?

      expect(product.errors[:code]).to include('Código já está em uso')
    end
  end
end

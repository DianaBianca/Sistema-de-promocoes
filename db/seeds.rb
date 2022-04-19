# frozen_string_literal: true

User.create!(email: 'admin@luizalabs.com.br', password: '123456')

Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                  code: 'NATAL10', discount_rate: 15, coupon_quantity: 4,
                  expiration_date: '22/12/2022')

Promotion.create!(name: 'Pascoa', description: 'Promoção de pascoa',
                  code: 'PASCOAA', discount_rate: 10, coupon_quantity: 6,
                  expiration_date: '22/02/2022')

Promotion.create!(name: 'Tech', description: 'Promoção de informatica',
                  code: 'TECH10', discount_rate: 20, coupon_quantity: 3,
                  expiration_date: '24/12/2022')

Promotion.create!(name: 'StarWars', description: 'Promoção Geek',
                  code: 'LUKE', discount_rate: 50, coupon_quantity: 4,
                  expiration_date: '02/12/2023')

Promotion.create!(name: 'Eliminação BBB', description: 'promoção BB',
                  code: 'BBB', discount_rate: 40, coupon_quantity: 5,
                  expiration_date: '22/12/2032')

ProductCategory.create!(name: 'Natal', code: 'HOHO')
ProductCategory.create!(name: 'Chocolate', code: 'OVOS')
ProductCategory.create!(name: 'Celulares', code: 'CEL')
ProductCategory.create!(name: 'Geeks', code: 'GEEK')
ProductCategory.create!(name: 'Globo', code: 'BBB')
ProductCategory.create!(name: 'Familia', code: 'FAM')

ProductCategoryPromotion.create!(product_category_id: 1, promotion_id: 1)
ProductCategoryPromotion.create!(product_category_id: 2, promotion_id: 2)
ProductCategoryPromotion.create!(product_category_id: 3, promotion_id: 3)
ProductCategoryPromotion.create!(product_category_id: 4, promotion_id: 4)
ProductCategoryPromotion.create!(product_category_id: 5, promotion_id: 5)

Coupon.create!(promotion_id: 4, code: 'Nerds-0001', status: 0)
Coupon.create!(promotion_id: 4, code: 'Nerds-0002', status: 0)
Coupon.create!(promotion_id: 4, code: 'Nerds-0003', status: 0)
Coupon.create!(promotion_id: 4, code: 'Nerds-0004', status: 0)

class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.references :promotion, null: false, foreign_key: true
      t.string :code
      t.integer :status, default: 0
      t.timestamps
    end
  end
end

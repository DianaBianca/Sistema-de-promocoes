# frozen_string_literal: true

class EmailValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:email, 'O e-mail precisa ser @luizalabs.com.br') unless record.email.include? '@luizalabs.com.br'
  end
end

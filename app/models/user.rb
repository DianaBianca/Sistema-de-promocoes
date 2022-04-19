# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_with EmailValidator

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

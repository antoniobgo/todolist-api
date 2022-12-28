# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :boards, dependent: :destroy

  validates :email, length: { maximum: 70 }, presence: true, uniqueness: true, email: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, on: :create

  before_save :to_lowercase

  private

  def to_lowercase
    email.downcase!
  end
end

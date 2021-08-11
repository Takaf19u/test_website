class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :email, presence: true
  validates :email, uniqueness: true, on: :save
  validates :password, presence: true,
                       format: { with: VALID_PASSWORD_REGEX }
  validates :email, length: { minimum: 8 }, on: :save
end

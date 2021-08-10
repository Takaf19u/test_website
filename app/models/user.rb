class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  has_one :user_informations, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: { with: VALID_PASSWORD_REGEX }
end

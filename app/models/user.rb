class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable

  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_one :user_detail, dependent: :destroy
  accepts_nested_attributes_for :user_detail

  validates :email, presence: true,
                    format: { with: VALID_MAIL_REGEX }
  validates :email, uniqueness: true, if: :not_my_address?
  validates :password, presence: true, on: :password
  with_options if: :password_present? do
    validates :password, length: { minimum: 8 },
                         format: { with: VALID_PASSWORD_REGEX, message: "#{I18n.t("errors.messages.password_format")}" },
                         eql_confirmation: { message: "#{I18n.t("errors.messages.password_confirmation")}" }
  end

  def password_present?
    self.password.present?
  end

  def not_my_address?
    return true if id.blank?
    user = User.find(id)
    !email.eql?(user.email)
  end

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
    valid?(:password)

    unless valid_password?(current_password)
      errors.add(:current_password, current_password.blank? ? :blank : :invalid)
    end

    assign_attributes(params, *options)

    result = if errors.blank?
      update(params, *options)
    end

    clean_up_passwords
    result
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable

  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_one :user_detail, dependent: :destroy
  accepts_nested_attributes_for :user_detail

  validates :email, presence: true
  validates :password, presence: true, on: :password

  with_options on: :email_all_checks   do
    validates :email, format: { with: VALID_MAIL_REGEX }
    validates :email, uniqueness: true, if: :not_my_address?
  end

  with_options on: :password_all_checks do
    validates :password, presence: true
    validates :password, length: { minimum: 8 },
                         format: { with: VALID_PASSWORD_REGEX, message: "#{I18n.t("errors.messages.password_format")}" },
                         eql_confirmation: { message: "#{I18n.t("errors.messages.password_confirmation")}" }
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
    valid?(:password_all_checks)

    unless valid_password?(current_password)
      errors.add(:current_password, current_password.blank? ? :blank : :invalid)
    end

    assign_attributes(params, *options)

    result = update(params, *options) if errors.blank?
    clean_up_passwords
    result
  end

  def self.correct_current_sign_in_at?(q)
    return true if q.blank?
    return true if q[:current_sign_in_at_gteq].blank? || q[:current_sign_in_at_lteq_end_of_day].blank?
    q[:current_sign_in_at_gteq] <= q[:current_sign_in_at_lteq_end_of_day]
  end
end

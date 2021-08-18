class EqlConfirmationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if record.password_confirmation.eql?(value)
    record.errors.add(attribute, options[:message] || :confirmation)
  end
end
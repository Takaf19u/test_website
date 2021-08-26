class CorrectTagValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if record.class.tags.keys.include?(value)
    record.errors.add(attribute, I18n.t("errors.messages.invalid"))
  end
end

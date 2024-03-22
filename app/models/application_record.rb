class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def enum_ko(column_name)
    return "없음" if send(column_name).nil?

    I18n.t("enum.#{self.class.name.underscore}.#{column_name}.#{send(column_name.to_s)}")
  end

  def self.enum_selectors(column_name)
    I18n.t("enum.#{name.underscore}.#{column_name}").invert
  rescue StandardError
    []
  end
end

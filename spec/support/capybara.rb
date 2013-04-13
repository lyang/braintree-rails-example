require 'capybara/rails'

module CapybaraHelper
  def fill_in_all(namespace, attributes)
    attributes.to_form_params(namespace).each do |attribute, value|
      find_field(attribute).set(value)
    end
  end
end

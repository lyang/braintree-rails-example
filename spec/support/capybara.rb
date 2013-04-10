require 'capybara/rails'

module CapybaraHelper
  def fill_in_all(attributes)
    attributes.each do |attribute, value|
      fill_in(attribute.to_s.humanize, :with => value)
    end
  end
end

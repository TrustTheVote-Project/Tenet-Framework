module Tenet
  module FormsHelper

    # renders the error block for a given object with the custom head message
    def form_errors(objects, message, options = {})
      errors = []
      if objects.present?
        [ objects ].flatten.compact.each { |o| errors += o.errors.full_messages }
      end
      hidden_class = errors.any? ? nil : 'hidden'

      content_tag(:div, [
        content_tag(:strong, message),
        content_tag(:ul, errors.map { |m| content_tag(:li, m) }.join.html_safe)
      ].join.html_safe, class: [ 'errors', hidden_class, options[:class] ].compact.join(' '))
    end

  end
end

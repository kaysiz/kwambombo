module FormHelper

  def my_text_field(form, field, errors=[], id='')
    content_tag(:div, class: 'form-group') do
      form.label(field, "#{field.to_s.humanize} #{errors.to_sentence}") +
      form.text_field(field, class: 'form-control', id: id)
    end
  end

  def my_email_field(form, field, errors=[])
    content_tag(:div, class: 'form-group') do
      form.label(field, "#{field.to_s.humanize} #{errors.to_sentence}") +
      form.email_field(field, class: 'form-control')
    end
  end

  def my_textarea_field(form, field, errors=[])
    content_tag(:div, class: 'form-group') do
      form.label(field, "#{field.to_s.humanize} #{errors.to_sentence}") +
      form.text_area(field, id: field, class: 'form-control')
    end
  end

  def my_password_field(form, field, errors=[])
    content_tag(:div, class: 'form-group') do
      form.label(field, "#{field.to_s.humanize} #{errors.to_sentence}") +
      form.password_field(field, autocomplete: 'off', class: 'form-control')
    end
  end

  def my_checkbox_field(form, field, errors=[])
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'checkbox') do
        form.label(field) do
          form.check_box(field, class: "mr-2" ) +
          "#{field.to_s.humanize} #{errors.to_sentence}"
        end
      end
    end
  end

  def my_radio_field(form, field, values, errors=[])
    form.label(field, "#{field.to_s.humanize} #{errors.to_sentence}") +
    content_tag(:div, class: 'form-group d-flex') do
      fields = ""
      values.each do |value|
        fields << radio_values(form, field, value)
      end
      fields.html_safe
    end
  end

protected

  def radio_values(form, field, value)
    content_tag(:div, class: 'form-check mr-3') do
      form.radio_button(field, value, id: field.to_s + '_' + value, class: "form-check-input") +
      form.label(value.humanize, for: field.to_s + '_' + value, class: "form-check-label")
    end
  end

end

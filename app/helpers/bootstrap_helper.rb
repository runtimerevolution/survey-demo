module BootstrapHelper
  def form_field_with_label form, name, field, field_arguments: [], field_options: {}, label_name: nil, label_options: {}, group_class: ''
    content_tag :div, class: "form-group #{group_class}" do
      concat form.label name, label_name, label_options
      concat form.send field, name, *field_arguments, field_options.merge(class: 'form-control')
    end
  end
end

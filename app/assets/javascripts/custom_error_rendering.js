// Custom error rendering for Client side validations gem

window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: function(element, settings, message) {

    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
    var form, inputErrorField, label, labelErrorField;
    form = $(element[0].form);
    if (element.data('valid') !== false && (form.find("label.message[for='" + (element.attr('id')) + "']")[0] == null)) {
      inputErrorField = $(settings.input_tag);
      labelErrorField = $(settings.label_tag);
      label = form.find("label[for='" + (element.attr('id')) + "']:not(.message)");
      if (element.attr('autofocus')) {
        element.attr('autofocus', false);
      }
      element.before(inputErrorField);
      inputErrorField.find('span#input_tag').replaceWith(element);
      inputErrorField.find('label.message').attr('for', element.attr('id'));
      labelErrorField.find('label.message').attr('for', element.attr('id'));
      labelErrorField.insertAfter(label);
      labelErrorField.find('label#label_tag').replaceWith(label);
    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->

      $(element).closest('.input-group, .form-group').addClass('has-error'); // for bootstrap

      var inputGroup = $(element).closest('.input-group')
      if (inputGroup.length > 0) {
        $(inputErrorField).find('label.message').detach().insertAfter(inputGroup)
      }

    }

    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
    return form.find("label.message[for='" + (element.attr('id')) + "']").text(message);
    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
  },
  remove: function(element, settings) {
    
    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
    var errorFieldClass, form, inputErrorField, label, labelErrorField;
    form = $(element[0].form);
    errorFieldClass = $(settings.input_tag).attr('class');
    inputErrorField = element.closest("." + (errorFieldClass.replace(" ", ".")));
    label = form.find("label[for='" + (element.attr('id')) + "']:not(.message)");
    labelErrorField = label.closest("." + errorFieldClass);
    if (inputErrorField[0]) {
      inputErrorField.find("#" + (element.attr('id'))).detach();
      inputErrorField.replaceWith(element);
    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
      // label.detach(); don't detach label
      

      form.find("label.message[for='" + (element.attr('id')) + "']").detach();
      $(element).closest('.input-group, .form-group').removeClass('has-error'); // for bootstrap
      

    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
      return labelErrorField.replaceWith(label);
    }
    // <-- CLIENT SIDE VALIDATIONS DEFAULT -->
    
  }
};
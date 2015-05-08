module ApplicationHelper
  def build_flash model
    if model.errors.count > 0
      flash.now[:alert] = model.errors.full_messages.join('<br/>').html_safe
    end
  end

  def correct_flash_name name
    case name
    when 'alert'
      'danger'
    when 'notice'
      'success'
    else
      name
    end
  end
end

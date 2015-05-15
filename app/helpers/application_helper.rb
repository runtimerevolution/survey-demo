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

  def is_active?(link_path)
    current_page?(link_path) ? 'active' : nil
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  private
  
  def number_of_people_who_also_answered_count option_id
    Survey::Answer.where(option_id: option_id).count
  end
end

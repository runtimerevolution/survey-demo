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
    @user ||= User.find_by(id: session[:user_id])
  end

  def user_form
    common_options = { validate: true, html: { class: 'user-form' } }
    form_options = current_user ? [ current_user, { url: change_user_name_path(current_user.id), method: :post, validate: true }.merge(common_options) ] : [ User.new, { validate: true }.merge(common_options) ]
    form_for *form_options do |f|
      yield f
    end
  end

  private
  
  def number_of_people_who_also_answered_count option_id
    Survey::Answer.where(option_id: option_id).count
  end
end

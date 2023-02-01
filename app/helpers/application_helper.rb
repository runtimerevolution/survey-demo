# frozen_string_literal: true

# Module ApplicationHelper
module ApplicationHelper
  def build_flash(model)
    return if model.errors.full_messages.length.positive?

    flash.now[:alert] = model.errors.full_messages.join('<br/>').html_safe
  end

  def correct_flash_name(name)
    case name
    when 'alert'
      'danger'
    when 'notice'
      'success'
    else
      name
    end
  end

  def is_active?(link_path) # rubocop:disable Naming/PredicateName
    current_page?(link_path) ? 'active' : nil
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id])
    @user
  end

  def user_form(&block)
    common_options = { validate: true, html: { class: 'user-form' } }
    form_options = if current_user
                     [current_user, { url: change_user_name_path(current_user.id),
                                      method: :post, validate: true }.merge(common_options)]
                   else
                     [User.new, { validate: true }.merge(common_options)]
                   end
    form_for(*form_options, &block)
  end

  private

  def number_of_people_who_also_answered_count(option_id)
    Survey::Answer.where(option_id: option_id).count
  end
end

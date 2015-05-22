class Survey::SurveyDecorator < Draper::Decorator
  delegate_all

  def type
    h.render 'survey_label', survey_type: self.survey_type
  end

  def render_proper_input form
    h.render "input_#{h.get_survey_type_string(self.survey_type)}", f: form
  end

  def name_link
    h.link_to self.name, h.new_attempt_path(survey_id: self.id), class: 'survey-name'
  end

  def edit_button
    generic_button h.edit_survey_path(self.id), 'Edit', 'pencil-square-o'
  end

  def delete_button
    generic_button h.survey_path(self.id), 'Delete', 'trash-o', link_options: { method: :delete, data: {confirm: "Are you sure you want to delete this survey?"} }
  end

  def number_of_questions
    self.questions.count
  end

  def number_of_attempts
    self.attempts.count
  end

  def score_message
    if h.is_score?(self.survey_type)
      h.tag(:br) <<
      h.content_tag(:div, 'In this type of survey, you have to enter a score for each question option (negative values are allowed)')
    end
  end

  def render_survey participant
    if self.avaliable_for_participant?(participant) then h.render 'form' else reset_attempts_message end
  end

  private

  def generic_button path, name, icon_id, link_options: {}
    h.link_to path, link_options.merge(class: 'btn btn-default btn-sm') do
      h.content_tag :i, " #{name}", class: "fa fa-#{icon_id}"
    end
  end

  def reset_attempts_message
    h.content_tag(:p, 'You have spent all the possible attempts to answer this Survey') <<
    h.content_tag(:p) do
      h.link_to h.delete_user_attempts_path(self.id, h.session[:user_id]), method: :delete do
        'Click here to reset the attempts'
      end
    end
  end
end

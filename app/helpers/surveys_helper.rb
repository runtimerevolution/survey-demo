module SurveysHelper
  def link_to_remove_field(name, f)
    f.hidden_field(:_destroy) +
    __link_to_function(raw(name), "removeField(this)", :id =>"remove-attach", class: 'btn btn-default')
  end

  def new_survey
    new_survey_path
  end

  def edit_survey(resource)
    edit_survey_path(resource)
  end

  def survey_scope(resource)
    if action_name =~ /new|create/
      surveys_path(resource)
    elsif action_name =~ /edit|update/
      survey_path(resource)
    end
  end

  def attempt_scope(resource)
    if action_name =~ /new|create/
     attempts_path(resource)
    elsif action_name =~ /edit|update/
      attempt_path(resource)
    end
  end

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,:child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    __link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
    :id=>"add-attach",
    :class=>"btn btn-default")
  end

  def get_answer_fields attempt
    attempt.survey.questions.map { |q| Survey::Answer.new(question_id: q.id) }
  end

  def the_chosen_one? answer, option
    if answer.option_id == option.id then 'chosen' else nil end
  end

  def number_of_people_who_also_answered option_id
    count = number_of_people_who_also_answered_count(option_id)
    "<span class='number'> #{count} </span> #{'answer'.pluralize}".html_safe
  end

  def get_color_of_option answer, option
    if is_quiz?(answer.question.survey.survey_type)
      if option.correct
        'bg-success'
      elsif the_chosen_one?(answer, option)
        'bg-danger'
      end
    elsif is_score?(answer.question.survey.survey_type)
      get_weight_html_class option
    end
  end

  def get_survey_type survey_type
    get_survey_types[survey_type] || get_survey_types.invert[survey_type]
  end

  def get_survey_types
    { 0 => 'quiz',
      1 => 'score',
      2 => 'poll' }
  end

  def is_quiz? something
    something == 0 || something == 'quiz'
  end

  def is_score? something
    something == 1 || something == 'score'
  end

  def is_poll? something
    something == 2 || something == 'poll'
  end

  def get_weight option
    return unless is_score?(option.question.survey.survey_type)
    option.weight > 0 ? "(+#{option.weight})" : "(#{option.weight})"
  end

  def get_weight_html_class option
    return 'bg-warning' if option.weight == 0
    option.weight > 0 ? 'bg-success' : 'bg-danger'
  end

  def surveys_count type = get_survey_types.keys
    Survey::Survey.where(survey_type: type).count
  end

  def number_of_questions survey
    survey.questions.count
  end

  def number_of_attempts survey
    survey.attempts.count
  end

  private

  def __link_to_function(name, on_click_event, opts={})
    link_to(name, 'javascript:;', opts.merge(onclick: on_click_event))
  end

  def has_weights? survey
    survey.questions.map(&:options).flatten.any? { |o| o.weight != 0 }
  end
end

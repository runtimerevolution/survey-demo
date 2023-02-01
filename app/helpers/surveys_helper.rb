# frozen_string_literal: true

# Module SurveysHelper
module SurveysHelper
  SURVEY_TYPES = { 0 => 'quiz',
                   1 => 'score',
                   2 => 'poll' }.freeze

  def link_to_remove_field(name, field)
    field.hidden_field(:_destroy) +
      __link_to_function(raw(name), 'removeField(this)', id: 'remove-attach')
  end

  def new_survey
    new_survey_path
  end

  def edit_survey(resource)
    edit_survey_path(resource)
  end

  def survey_scope(resource)
    case action_name
    when /new|create/
      surveys_path(resource)
    when /edit|update/
      survey_path(resource)
    end
  end

  def new_attempt
    new_attempt_path
  end

  def attempt_scope(resource)
    case action_name
    when /new|create/
      attempts_path(resource)
    when /edit|update/
      attempt_path(resource)
    end
  end

  def link_to_add_field(name, fld, association)
    new_object = fld.object.class.reflect_on_association(association).klass.new
    fields = fld.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end
    __link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
                       id: 'add-attach',
                       class: 'btn btn-small btn-info')
  end

  def get_answer_fields(attempt)
    attempt.survey.questions.map { |q| Survey::Answer.new(question_id: q.id) }
  end

  def the_chosen_one?(answer, option)
    answer.option_id == option.id ? 'chosen' : nil
  end

  def number_of_people_who_also_answered(option_id)
    count = number_of_people_who_also_answered_count(option_id)
    "<span class='number'> #{count} </span> #{'answer'.pluralize}".html_safe
  end

  def get_color_of_option(answer, option)
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

  def get_survey_type(survey_type)
    key, _value = survey_type
    SURVEY_TYPES[key] || SURVEY_TYPES.invert[key]
  end

  def is_quiz?(something) # rubocop:disable Naming/PredicateName
    [0, 'quiz'].include?(something)
  end

  def is_score?(something) # rubocop:disable Naming/PredicateName
    [1, 'score'].include?(something)
  end

  def is_poll?(something) # rubocop:disable Naming/PredicateName
    [2, 'poll'].include?(something)
  end

  def get_weight(option)
    return unless is_score?(option.question.survey.survey_type)

    option.weight.positive? ? "(+#{option.weight})" : "(#{option.weight})"
  end

  def get_weight_html_class(option)
    return 'bg-warning' if option.weight.zero?

    option.weight.positive? ? 'bg-success' : 'bg-danger'
  end

  def surveys_count(type = SURVEY_TYPES.keys)
    ::Survey::Survey.where(survey_type: type).count
  end

  def number_of_questions(survey)
    survey.questions.count
  end

  def number_of_attempts(survey)
    survey.attempts.count
  end

  private

  def __link_to_function(name, on_click_event, opts = {})
    link_to(name, 'javascript:;', opts.merge(onclick: on_click_event))
  end

  def has_weights?(survey) # rubocop:disable Naming/PredicateName
    survey.questions.map(&:options).flatten.any? { |o| o.weight != 0 }
  end
end

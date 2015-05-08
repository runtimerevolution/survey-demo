module SurveysHelper
  def link_to_remove_field(name, f)
    f.hidden_field(:_destroy) +
    __link_to_function(raw(name), "removeField(this)", :id =>"remove-attach", class: 'btn btn-default')
  end
  #"survey_attempt"=> {"answers_attributes"=>{"0"=>{"question_id"=>"1", "option_id"=>"2"}, "1"=>{"question_id"=>"2", "option_id"=>"5"}}}
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

  private

  def __link_to_function(name, on_click_event, opts={})
    link_to(name, 'javascript:;', opts.merge(onclick: on_click_event))
  end
end

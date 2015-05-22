class SurveysController < ApplicationController

  before_filter :load_survey, only: [:show, :edit, :update, :destroy]

  def index
    type = view_context.get_survey_type_number(params[:type])
    query = if type && type.is_a?(Integer) then Survey::Survey.where(survey_type: type) else Survey::Survey end
    @surveys = query.order(created_at: :desc).page(params[:page]).per(15).decorate
  end

  def new
    @survey = Survey::Survey.new(survey_type: view_context.get_survey_type_number(params[:type])).decorate
  end

  def create
    @survey = Survey::Survey.new(params_whitelist)
    if @survey.valid? && @survey.save
      default_redirect
    else
      build_flash(@survey = @survey.decorate)
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @survey.update_attributes(params_whitelist)
      default_redirect
    else
      build_flash(@survey)
      render :edit
    end
  end

  def destroy
    @survey.destroy
    default_redirect
  end

  private

  def default_redirect
    redirect_to surveys_path, notice: I18n.t("surveys_controller.#{action_name}")
  end

  def load_survey
    @survey = Survey::Survey.find(params[:id]).decorate
  end

  def params_whitelist
    params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes << :survey_type)
  end

end

class SurveysController < ApplicationController

  before_filter :load_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = Survey::Survey.all
  end

  def new
    @survey = Survey::Survey.new
  end

  def create
    @survey = Survey::Survey.new(params_whitelist)
    if @survey.valid? && @survey.save
      default_redirect
    else
      @survey_type = params_whitelist[:survey_type].to_i
      build_flash(@survey)
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
      @survey_type = params_whitelist[:survey_type].to_i
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
    @survey = Survey::Survey.find(params[:id])
  end

  def params_whitelist
    params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes << :survey_type)
  end

end

class AddSurveyTypeToSurveySurvey < ActiveRecord::Migration[7.0]
  def change
    add_column :survey_surveys, :survey_type, :integer
  end
end

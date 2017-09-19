class EmotionalQuestionsController < ApplicationController
	# before_action :set_question, only: [:show, :update, :destroy]

  # # GET /questions
  def index
    @questions = Question.where("category = '2'")
    json_response(@questions)
  end

  # private

  def question_params
    # whitelist params
    params.permit( :category, :age_range, :gender, :question_type, :options, :question_text, :coach_id, :player_id )
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

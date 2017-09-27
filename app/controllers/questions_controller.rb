class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    if params[:question_type] != nil and params[:category] != nil
      @questions = Question.where("question_type = ? AND category = ?", params[:question_type], params[:category])
    elsif params[:question_type] != nil
      @questions = Question.where("question_type = ?", params[:question_type])
    elsif params[:category] != nil
      @questions = Question.where("category = ?", params[:category])
    else
      @questions = Question.all
    end
    json_response(@questions)
  end

  # POST /questions
  def create
    @question = Question.create!(question_params)
    json_response(@question, :created)
  end

  # GET /questions/:id
  def show
    json_response(@question)
  end

  # PUT /questions/:id
  def update
    @question.update(question_params)
    head :no_content
  end

  # DELETE /questions/:id
  def destroy
    @question.destroy
    head :no_content
  end

  private

  def question_params
    # whitelist params
    params.permit( :category, :age_range, :gender, :question_type, :options, :question_text, :coach_id, :player_id )
  end

  def set_question
    @question = Question.find(params[:id])
  end
end

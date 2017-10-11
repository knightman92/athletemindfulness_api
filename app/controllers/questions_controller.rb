class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :update, :destroy]

  # GET /questions
  def index
    if params[:category] != nil and params[:age_range] != nil and params[:question_type] != nil and params[:gender] != nil
      @questions = Question.where("category = ? AND age_range = ? AND question_type = ? AND gender = ?", params[:category], params[:age_range], params[:question_type], params[:gender])
    elsif params[:category] != nil and params[:age_range] != nil and params[:question_type] != nil
      @questions = Question.where("category = ? AND age_range = ? AND question_type = ?", params[:category], params[:age_range], params[:question_type])
    elsif params[:gender] != nil and params[:age_range] != nil and params[:question_type] != nil
      @questions = Question.where("gender = ? AND age_range = ? AND question_type = ?", params[:gender], params[:age_range], params[:question_type])
    elsif params[:gender] != nil and params[:category] != nil and params[:question_type] != nil
      @questions = Question.where("gender = ? AND category = ? AND question_type = ?", params[:gender], params[:category], params[:question_type])
    elsif params[:gender] != nil and params[:category] != nil and params[:age_range] != nil
      @questions = Question.where("gender = ? AND category = ? AND age_range = ?", params[:gender], params[:category], params[:age_range])
    elsif params[:gender] != nil and params[:category] != nil
      @questions = Question.where("gender = ? AND category = ?", params[:gender], params[:category])
    elsif params[:age_range] != nil and params[:category] != nil
      @questions = Question.where("age_range = ? AND category = ?", params[:age_range], params[:category])
    elsif params[:age_range] != nil and params[:gender] != nil
      @questions = Question.where("age_range = ? AND gender = ?", params[:age_range], params[:gender])
    elsif params[:question_type] != nil and params[:age_range] != nil
      @questions = Question.where("question_type = ? AND age_range = ?", params[:question_type], params[:age_range])
    elsif params[:question_type] != nil and params[:gender] != nil
      @questions = Question.where("question_type = ? AND gender = ?", params[:question_type], params[:gender])
    elsif params[:question_type] != nil and params[:category] != nil
      @questions = Question.where("question_type = ? AND category = ?", params[:question_type], params[:category])
    elsif params[:gender] != nil
      @questions = Question.where("gender = ?", params[:gender])
    elsif params[:age_range] != nil
      @questions = Question.where("age_range = ?", params[:age_range])
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

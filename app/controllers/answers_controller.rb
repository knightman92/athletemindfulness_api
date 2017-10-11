class AnswersController < ApplicationController
	before_action :set_answer, only: [:show, :update, :destroy]

  # GET /answers
  def index
    if params[:player_id] != nil and params[:question_id] != nil
      @answers = Answer.where("player_id = ? AND question_id = ?", params[:player_id], params[:question_id])
    elsif params[:player_id] != nil
      @answers = Answer.where("player_id = ?", params[:player_id])
    elsif params[:question_id] != nil
      @answers = Answer.where("question_id = ?", params[:question_id])
    else
      @answers = Answer.all
    end
    json_response(@answers)
  end

  # POST /answers
  def create
    puts params 
    @answer = Answer.create!(answer_params)
    json_response(@answer, :created)
  end

  # GET /answers/:id
  def show
    json_response(@answer)
  end

  # PUT /answers/:id
  def update
    @answer.update(answer_params)
    head :no_content
  end

  # DELETE /answers/:id
  def destroy
    @answer.destroy
    head :no_content
  end

  private

  def answer_params
    # whitelist params
    params.permit( :answer, :player_id, :question_id )
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
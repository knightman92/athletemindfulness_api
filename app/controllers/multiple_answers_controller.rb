class MultipleAnswersController < ApplicationController
	def create_multiple
		# puts "This is "
		# puts params
		# puts "ohhhh yaa"

		@answers = params["_json"].map do |params_hash|
			whitelisted_params = params_hash.permit( :answer, :player_id, :question_id )
			Answer.new(whitelisted_params)
		end

    # Check that all the answers are valid and can be saved
    if @answers.all? { |answer| answer.valid? }
      # Now we know they are valid, we save each answer
      @answers.each do |answer|
        answer.save
      end

      # and then respond with the json versions of the saved ticker_activites
      json_response(@answers, :created)
    else
      # Since at least some of the answers are invalid,
      # we can't save *all* the answers, so we
      # respond with the validation errors instead
      @errors = @answers.map { |answer|
        answer.errors
      }
      json_response(@errors, :unprocessable_entity)
    end
	end
end

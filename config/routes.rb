Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "coaches#index"

  devise_for :players, path: 'players', controllers: { sessions: "players/sessions", registrations: "players/registrations" }
  devise_for :coaches, path: 'coaches', controllers: { sessions: "coaches/sessions", registrations: "coaches/registrations" }
  # devise_for :questions, path: 'mental_questions', controllers: { }


  # GET questions for each category
  resources :mental_questions
  resources :emotional_questions
  resources :physical_questions
  resources :training_questions
  resources :competition_questions
  resources :social_questions

	resources :players do
		resources :questions do
			resources :answers, :notifications
		end
	end 

	resources :coaches do
		resources :questions, :players
	end
  
  resources :questions do 
  	resources :notifications
  end

  resources :notifications
end

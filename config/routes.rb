Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "questions#index"

  devise_for :players, path: 'players', controllers: { sessions: "players/sessions", registrations: "players/registrations" }, defaults: { format: :json}
  devise_for :coaches, path: 'coaches', controllers: { sessions: "coaches/sessions", registrations: "coaches/registrations" }, defaults: { format: :json}

  post '/multiple_answers', to: 'multiple_answers#create_multiple'

  resources :leaderboard

  resources :coaches_players
  resources :players 
  resources :answers
  resources :coaches
  resources :questions
  resources :notifications
end
